#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "kernel/vma.h"
#include "user/user.h"

#define FB_SIZE         1024 * 480 * 4

#define SCREEN_WIDTH    640
#define SCREEN_HEIGHT   480

#define TILE            20
#define GRID_WIDTH      (SCREEN_WIDTH  / TILE)
#define GRID_HEIGHT     (SCREEN_HEIGHT / TILE)

#define MAX_SNAKE_TILES (GRID_WIDTH * GRID_HEIGHT)

struct cell {
	uint32_t x;
	uint32_t y;
};

/* Devices */
static int uart_fd;
static int fb_fd;
static int ur_fd;

/* Settings */
static int quit_game = false;
static uint32_t* front_fb;
static uint32_t* fb;

/* Game Objects */
static struct cell food;
static struct cell snake[MAX_SNAKE_TILES];
static uint32_t snake_len;

static int dir_x = 0;
static int dir_y = 0;

static int pending_dir_x = 1;
static int pending_dir_y = 0;

void swap_buffers(void) {
	memcpy(front_fb, fb, FB_SIZE);
}

int open_uart(void) {
	int uart_fd = open("/dev/uart0", O_RDWR | O_NONBLOCK);
	if (uart_fd < 0) {
		printf("open /dev/uart0 failed\n");
		exit(1);
	}
	return uart_fd;
}

int open_fb(void) {
	int fb_fd = open("/dev/fb0", O_RDWR);
	if (fb_fd < 0) {
	    printf("open /dev/fb0 failed\n");
	    exit(1);
	}
	return fb_fd;
}

int open_urandom(void) {
	int ur_fd = open("/dev/urandom", O_RDONLY);
    if (ur_fd < 0) {
        printf("open /dev/urandom failed\n");
        exit(1);
    }
	return ur_fd;
}

uint32_t* make_fb(void)
{
	uint32_t* fb = malloc(FB_SIZE);
	if (fb == 0) {
		printf("malloc failed!\n");
		exit(1);
	}
	return fb;
}

uint32_t uru32(uint32_t limit) {
	uint32_t r = 0;
	int n;

	n = read(ur_fd, &r, sizeof(r));

	if(n == sizeof(r)) {
		return (r % limit);
	}
	else {
		printf("read urandom failed\n");
		exit(1);
	}

	return (r % limit);
}

uint32_t* mmap_fb(int fb_fd)
{
    uint32_t *fb = (uint32_t *)mmap(0, FB_SIZE, PROT_READ | PROT_WRITE, 0, fb_fd, 0);
    if ((uint64_t)fb == 0xffffffffffffffffL) {
        printf("mmap failed\n");
        exit(1);
    }
	return fb;
}

void poll_events(void)
{
	char key;
	while(read(uart_fd, &key, 1) > 0){
		if(key == 'q'){
			quit_game = true;
			return;
		}

		if(key == 'w' && pending_dir_y != 1){
			pending_dir_x = 0;
			pending_dir_y = -1;
		}
		else if(key == 's' && pending_dir_y != -1){
			pending_dir_x = 0;
			pending_dir_y = 1;
		}
		else if(key == 'a' && pending_dir_x != 1){
			pending_dir_x = -1;
			pending_dir_y = 0;
		}
		else if(key == 'd' && pending_dir_x != -1){
			pending_dir_x = 1;
			pending_dir_y = 0;
		}
	}
}

int snake_occupies(int x, int y)
{
	int i;
	for(i = 0; i < snake_len; i++){
		if(snake[i].x == x && snake[i].y == y)
			return 1;
	}
	return 0;
}

void spawn_food(void)
{
	int x, y;

	for(;;){
		x = uru32(GRID_WIDTH);
		y = uru32(GRID_HEIGHT);
		if(!snake_occupies(x, y))
			break;
	}

	food.x = x;
	food.y = y;
}

void reset_game(void)
{
	snake_len = 3;
	snake[0].x = GRID_WIDTH / 2;
	snake[1].x = GRID_WIDTH / 2 - 1;
	snake[2].x = GRID_WIDTH / 2 - 2;
	snake[0].y = GRID_HEIGHT / 2;
	snake[1].y = GRID_HEIGHT / 2;
	snake[2].y = GRID_HEIGHT / 2;

	dir_x = 1;
	dir_y = 0;
	pending_dir_x = 1;
	pending_dir_y = 0;

	spawn_food();
}

void clear_screen() {
	memset(fb, 0, FB_SIZE);
	swap_buffers();
}

void step_game(void)
{
	int i;
	int new_x, new_y;
	int grow = 0;

	dir_x = pending_dir_x;
	dir_y = pending_dir_y;

	new_x = snake[0].x + dir_x;
	new_y = snake[0].y + dir_y;

	/* wall collision */
	if(new_x < 0 || new_x >= GRID_WIDTH || new_y < 0 || new_y >= GRID_HEIGHT){
		reset_game();
		return;
	}

	/* self collision */
	for(i = 0; i < snake_len; i++){
		if(snake[i].x == new_x && snake[i].y == new_y){
			reset_game();
			return;
		}
	}

	/* food */
	if(new_x == food.x && new_y == food.y){
		grow = 1;
		spawn_food();
	}

	/* move body */
	if(grow == 0){
		for(i = snake_len - 1; i > 0; i--)
			snake[i] = snake[i - 1];
	} else {
		for(i = snake_len; i > 0; i--)
			snake[i] = snake[i - 1];
		snake_len++;
	}

	snake[0].x = new_x;
	snake[0].y = new_y;

	if(snake_len >= MAX_SNAKE_TILES){
		reset_game();
	}
}

void fill_rect(int x, int y, int w, int h, uint32_t color)
{
	int rx, ry;

	if(x < 0){
		w += x;
		x = 0;
	}
	if(y < 0){
		h += y;
		y = 0;
	}

	if(x + w > SCREEN_WIDTH)
		w = SCREEN_WIDTH - x;
	if(y + h > SCREEN_HEIGHT)
		h = SCREEN_HEIGHT - y;

	for(ry = 0; ry < h; ry++) {
		uint32_t *row = fb + (y + ry) * 1024 + x;
		for(rx = 0; rx < w; rx++) {
			row[rx] = color;
		}
	}
}

void draw_game() {
	/* background grid tone */
	fill_rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0x00101010);

	/* food */
	fill_rect(food.x * TILE, food.y * TILE, TILE, TILE, 0x00FF0000);

	/* snake body */
	for(int i = snake_len - 1; i >= 0; i--){
		uint32_t color = 0x0000AA00;

		if(i == 0) {
			color = 0x0000FF00;
		}

		fill_rect(snake[i].x * TILE, snake[i].y * TILE, TILE, TILE, color);
	}

	/* simple border */
	fill_rect(0, 0, SCREEN_WIDTH, 2, 0x00FFFFFF);
	fill_rect(0, SCREEN_HEIGHT - 2, SCREEN_WIDTH, 2, 0x00FFFFFF);
	fill_rect(0, 0, 2, SCREEN_HEIGHT, 0x00FFFFFF);
	fill_rect(SCREEN_WIDTH - 2, 0, 2, SCREEN_HEIGHT, 0x00FFFFFF);
}

int main(int argc, char *argv[])
{
	uart_fd = open_uart();
	fb_fd = open_fb();
	ur_fd = open_urandom();

	front_fb = mmap_fb(fb_fd);
	fb = make_fb();

	reset_game();

	while (!quit_game) {
		step_game();
		draw_game();

		swap_buffers();
		poll_events();
	}

	clear_screen();

	free(fb);
	munmap(front_fb, FB_SIZE);
	close(uart_fd);
	close(fb_fd);
	close(ur_fd);
	exit(0);
}
