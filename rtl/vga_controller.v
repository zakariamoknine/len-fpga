module vga_controller (
	input  wire        clk, /* 25MHz from MMCM */
	input  wire        resetn, /* Active LOW reset */
	
	/* PORT A signals, forwarded to xpm_memory_tdpram */
	input  wire [18:0] bram_addra,
	input  wire        bram_clka,
	input  wire [31:0] bram_dina,
	output wire [31:0] bram_douta,
	input  wire        bram_ena,
	input  wire        bram_rsta,
	input  wire [ 3:0] bram_wea,
	
	/* VGA signals */
	output reg  [ 3:0] vga_red,
	output reg  [ 3:0] vga_green,
	output reg  [ 3:0] vga_blue,
	output wire        vga_hsync,
	output wire        vga_vsync
);

	/* PORT B signals */
	reg  [16:0] bram_addrb;
	wire        bram_clkb;
	wire [31:0] bram_dinb;
	wire [31:0] bram_doutb;
	wire        bram_enb;
	wire        bram_rstb;
	wire [ 3:0] bram_web;
	
	/* Fixed PORT B signals, since VGA will only perform read operations */
	assign bram_clkb = clk;
	assign bram_rstb = ~resetn;
	assign bram_dinb = 32'b0;
	assign bram_web  = 4'b0000;
	assign bram_enb  = 1'b1;

	/* VGA timings for 640x480 @60Hz */
	localparam H_VISIBLE      = 640;
	localparam H_FRONT_PORCH  = 16;
	localparam H_SYNC_PULSE   = 96;
	localparam H_BACK_PORCH   = 48;
	localparam H_TOTAL        = H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH; // 800

	localparam V_VISIBLE      = 480;
	localparam V_FRONT_PORCH  = 10;
	localparam V_SYNC_PULSE   = 2;
	localparam V_BACK_PORCH   = 33;
	localparam V_TOTAL        = V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH; // 525

	/* Pipeline depth, 4 Stages */
	localparam PIPELINE_DEPTH = 4;
	
	reg [PIPELINE_DEPTH-1:0] hsync_pipe;
	reg [PIPELINE_DEPTH-1:0] vsync_pipe;
	reg [PIPELINE_DEPTH-1:0] visible_pipe;

	reg [ 1:0] byte_index_stage1;
	reg [ 1:0] byte_index_stage2;
	reg [ 7:0] pixel_byte_stage3;

	/* Pipeline inputs */
	wire [18:0] pixel_addr;
	wire hsync;
	wire vsync;
	wire visible;
	
	reg [ 9:0] hcount;
	reg [ 9:0] vcount;

	assign hsync = ~((hcount >= (H_VISIBLE + H_FRONT_PORCH)) &&
		(hcount <  (H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE)));
		
	assign vsync = ~((vcount >= (V_VISIBLE + V_FRONT_PORCH)) &&
		(vcount <  (V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE)));
	assign visible = (hcount < H_VISIBLE) && (vcount < V_VISIBLE);

	assign pixel_addr = ((vcount << 9) + (vcount << 7)) + hcount;

	always @(posedge clk) begin
		if (!resetn) begin
			hcount <= 0;
			vcount <= 0;
		end else begin
			if (hcount == H_TOTAL - 1) begin
				hcount <= 0;
				if (vcount == V_TOTAL - 1)
					vcount <= 0;
				else
					vcount <= vcount + 1;
			end else begin
				hcount <= hcount + 1;
			end
		end
	end

	/* 
	 * STAGE 1: Latch current pixel to bram_addrb 
	 *
	 * In this stage, we simply latch the value of the pixel counter
	 * to the bram_addrb register, this way, in stage 3 the data
	 * will be ready and stable at bram_doutb, which will contain
	 * a pack of 4 pixels
	 *
	 * To select which pixel, we also need to push the byte_index
	 * though the pipeline, to later use it to select the right
	 * pixel and drive VGA signals correctly
	 *
	 * Also, vsync_pipe, hsync_pipe, and visible_pipe will move
	 * through the entire pipeline, stage by stage
	 */
	always @(posedge clk) begin
		if (!resetn) begin
			bram_addrb <= 0;
			vsync_pipe <= 0;
			hsync_pipe <= 0;
			visible_pipe <= 0;
			byte_index_stage1 <= 0;
		end else begin
			if (visible) begin
				bram_addrb <= pixel_addr[18:2];
			end else begin
				bram_addrb <= 0;
			end

			byte_index_stage1 <= pixel_addr[1:0];
			
			hsync_pipe <= {hsync_pipe[PIPELINE_DEPTH-2:0], hsync};
			vsync_pipe <= {vsync_pipe[PIPELINE_DEPTH-2:0], vsync};
			visible_pipe <= {visible_pipe[PIPELINE_DEPTH-2:0], visible};
		end
	end

	/* 
	 * STAGE 2: Wait for bram_doutb, 1 clock cycle latency 
	 *
	 * In this stage, we do nothing but wait for the bram_doutb
	 * to arrive the next stage, we only push byte_index to be
	 * used in the next stage
	 *
	 * vsync_pipe, hsync_pipe and visible_pipe continue to move
	 * through the pipeline
	 */
	always @(posedge clk) begin
		if (!resetn) begin
			byte_index_stage2 <= 0;
		end else begin
			/* Forward byte index to the next stage */
			byte_index_stage2 <= byte_index_stage1;
		end
	end

	/* 
	 * STAGE 3: Select the right pixel
	 *
	 * In this stage, bram_doutb is ready, we select the right
	 * pixel using byte_index_stage2 and store it in
	 * pixel_byte_stage3
	 *
	 * vsync_pipe, hsync_pipe and visible_pipe continue to move
	 * through the pipeline
	 */
	always @(posedge clk) begin
		if (!resetn) begin
			pixel_byte_stage3 <= 8'b0;
		end else begin
			case (byte_index_stage2)
				2'b00: pixel_byte_stage3 <= bram_doutb[7:0];
				2'b01: pixel_byte_stage3 <= bram_doutb[15:8];
				2'b10: pixel_byte_stage3 <= bram_doutb[23:16];
				2'b11: pixel_byte_stage3 <= bram_doutb[31:24];
				default: pixel_byte_stage3 <= 8'b0;
			endcase
		end
	end

	/*
	 * STAGE 4: Drive vga_vsync, vga_hsync and vga_(r/g/b)
	 *
	 * This is the final stage, we use pixel_byte_stage3 to assign
	 * the values of vga_(r/g/b) registers, and drive vga_hsync
	 * and vga_vsync using the last register slice in the
	 * corresponding pipe
	 */
	assign vga_hsync = hsync_pipe[PIPELINE_DEPTH-1];
	assign vga_vsync = vsync_pipe[PIPELINE_DEPTH-1];

	always @(posedge clk) begin
		if (!resetn) begin
			vga_red   <= 0;
			vga_green <= 0;
			vga_blue  <= 0;
		end else if (visible_pipe[PIPELINE_DEPTH-1]) begin
			vga_red   <= {pixel_byte_stage3[7:5],
			       	      pixel_byte_stage3[7]};

			vga_green <= {pixel_byte_stage3[4:2],
				      pixel_byte_stage3[4]};

			vga_blue  <= {pixel_byte_stage3[1:0],
				      pixel_byte_stage3[1],
				      pixel_byte_stage3[0]};
		end else begin
			vga_red   <= 0;
			vga_green <= 0;
			vga_blue  <= 0;
		end
	end

	xpm_memory_tdpram #(
		.ADDR_WIDTH_A(17),
		.ADDR_WIDTH_B(17),
		.BYTE_WRITE_WIDTH_A(8),
		.BYTE_WRITE_WIDTH_B(8),
		.CLOCKING_MODE("independent_clock"),
		.MEMORY_PRIMITIVE("auto"),
		.MEMORY_SIZE(2457600), /* Enough for 640x480, 8-bit per pixel */
		.RAM_DECOMP("auto"), /* NOTE: changing to "power" might fix some issues */
		.READ_DATA_WIDTH_A(32),
		.READ_DATA_WIDTH_B(32),
		.READ_LATENCY_A(1),
		.READ_LATENCY_B(1),
		.WRITE_DATA_WIDTH_A(32),
		.WRITE_DATA_WIDTH_B(32)
	)
	fb_bram (
		.douta(bram_douta),
		.addra(bram_addra[18:2]),
		.clka(bram_clka),
		.dina(bram_dina),
		.ena(bram_ena),
		.rsta(bram_rsta),
		.wea(bram_wea),

		.doutb(bram_doutb),
		.addrb(bram_addrb),
		.clkb(bram_clkb),
		.dinb(bram_dinb),
		.enb(bram_enb),
		.rstb(bram_rstb),
		.web(bram_web)
	);

endmodule
