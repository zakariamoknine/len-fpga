#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "kernel/vma.h"
#include "user/user.h"

#include "../misc/vga_font.h"

#define FB_SIZE         1024 * 480 * 4
#define FB_STRIDE       1024

#define COLS            80
#define ROWS            30

#define MAX_LINES       1024
#define LINE_WIDTH      80

#define TEXT_Y_START    1
#define TEXT_Y_END      26
#define TEXT_X_START    1
#define TEXT_X_END      78
#define VIEWPORT_HEIGHT (TEXT_Y_END - TEXT_Y_START + 1)
#define VIEWPORT_WIDTH  (TEXT_X_END - TEXT_X_START + 1)

#define STATUS_STRIP    27
#define STATUS_TEXT     28

#define COLOR_WHITE     0xFFFFFFFF
#define COLOR_BLACK     0x00000000

int quit = false;

char document[MAX_LINES][LINE_WIDTH];

int doc_x = 0;
int doc_y = 0;

int row_off = 0;

char* filename;
static int fb_fd;
uint32_t* fb = NULL;
static int uart_fd;

int open_uart(void) {
    int fd = open("/dev/uart0", O_RDWR | O_NONBLOCK);
    if (fd < 0) exit(1);
    return fd;
}

void init_fb(void) {
    fb_fd = open("/dev/fb0", O_RDWR);
    fb = (uint32_t *)mmap(0, FB_SIZE, PROT_READ | PROT_WRITE, 0, fb_fd, 0);
}

void draw_tile(int x, int y, char c, uint32_t fg, uint32_t bg) {
    if (x < 0 || x >= COLS || y < 0 || y >= ROWS) return;
    uint8_t *glyph = &vga_font[(uint8_t)c * 16];
    uint32_t px = x * 8;
    uint32_t py = y * 16;
    for (int row = 0; row < 16; row++) {
        uint8_t bits = glyph[row];
        for (int col = 0; col < 8; col++) {
            uint32_t color = (bits & (1 << (7 - col))) ? fg : bg;
            fb[(py + row) * FB_STRIDE + (px + col)] = color;
        }
    }
}

void fill_tile(int x, int y, uint32_t color) {
    uint32_t px = x * 8;
    uint32_t py = y * 16;
    for (int r = 0; r < 16; r++)
        for (int c = 0; c < 8; c++)
            fb[(py + r) * FB_STRIDE + (px + c)] = color;
}

void present(void) {
    if (doc_y < row_off) {
        row_off = doc_y;
    }
    if (doc_y >= row_off + VIEWPORT_HEIGHT) {
        row_off = doc_y - VIEWPORT_HEIGHT + 1;
    }

    for (int y = 0; y < ROWS; y++) {
        for (int x = 0; x < COLS; x++) {
            if (y == 0 || y == ROWS - 1 || x == 0 || x == COLS - 1 || y == STATUS_STRIP) {
                fill_tile(x, y, COLOR_WHITE);
            } 
			else if (y == STATUS_TEXT) {
				int len = strlen(filename);
				int file_idx = x - 1; 
				char c = (file_idx >= 0 && file_idx < len) ? filename[file_idx] : ' ';
				draw_tile(x, y, c, COLOR_WHITE, COLOR_BLACK);
			}
            else {
                int file_y = row_off + (y - TEXT_Y_START);
                int file_x = x - TEXT_X_START;

                if (file_y < MAX_LINES && file_x >= 0 && file_x < LINE_WIDTH) {
                    uint32_t bg = (file_x == doc_x && file_y == doc_y) ? 0x00444444 : COLOR_BLACK;
                    draw_tile(x, y, document[file_y][file_x], COLOR_WHITE, bg);
                }
            }
        }
    }
}

void load_file(char *path) {
    memset(document, ' ', sizeof(document));
    int fd = open(path, O_RDONLY);
    if (fd < 0) return;

    char c;
    int x = 0, y = 0;
    while (read(fd, &c, 1) > 0 && y < MAX_LINES) {
        if (c == '\n') {
            x = 0; y++;
        } else if (c >= 32 && c <= 126) {
            if (x < LINE_WIDTH) document[y][x++] = c;
        }
    }
    close(fd);
}

void save_file(char *path) {
    int fd = open(path, O_WRONLY | O_CREATE);
    if (fd < 0) return;

    int last_row = 0;
    for (int y = MAX_LINES - 1; y >= 0; y--) {
        for (int x = 0; x < LINE_WIDTH; x++) {
            if (document[y][x] != ' ') { last_row = y; goto found; }
        }
    }

found:
    for (int y = 0; y <= last_row; y++) {
        int last_x = -1;
        for (int x = 0; x < LINE_WIDTH; x++) {
            if (document[y][x] != ' ') last_x = x;
        }
        if (last_x != -1) {
            write(fd, document[y], last_x + 1);
        }
        write(fd, "\n", 1);
    }
    close(fd);
}

void poll_events(void) {
    uint8_t c;
    if (read(uart_fd, &c, 1) <= 0) return;

    if (c == 27) {
        uint8_t seq[2];
        if (read(uart_fd, &seq[0], 1) > 0 && read(uart_fd, &seq[1], 1) > 0) {
            if (seq[0] == '[') {
                if (seq[1] == 'A' && doc_y > 0) doc_y--;
                if (seq[1] == 'B' && doc_y < MAX_LINES - 1) doc_y++;
                if (seq[1] == 'C' && doc_x < LINE_WIDTH - 1) doc_x++;
                if (seq[1] == 'D' && doc_x > 0) doc_x--;
            }
        }
    } 
    else if (c == 8 || c == 127 || c == 23) {
        if (doc_x > 0) {
            doc_x--;
            document[doc_y][doc_x] = ' ';
        } else if (doc_y > 0) {
            doc_y--;
            doc_x = LINE_WIDTH - 1;
        }
    }
    else if (c == '\r' || c == '\n') {
        if (doc_y < MAX_LINES - 1) {
            doc_y++;
            doc_x = 0;
        }
    }
    else if (c == 17) { quit = true; }
    else if (c >= 32 && c <= 126) {
        document[doc_y][doc_x] = c;
        if (doc_x < LINE_WIDTH - 1) {
            doc_x++;
        } else if (doc_y < MAX_LINES - 1) {
            doc_x = 0;
            doc_y++;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
	   	printf("Usage: text <filename>\n");
	   	exit(1);
	}
    filename = argv[1];

    uart_fd = open_uart();
    init_fb();

    load_file(filename);
    
    memset(fb, 0, FB_SIZE);
    while (!quit) {
        poll_events();
        present();
    }

    save_file(filename);

    memset(fb, 0, FB_SIZE);
    munmap(fb, FB_SIZE);
    close(uart_fd);
    close(fb_fd);
    exit(0);
}
