`timescale 1ns / 1ps

module vga_controller (
	input  wire        clk,
	input  wire        resetn,

	input  wire [16:0] bram_addra,
	input  wire        bram_clka,
	input  wire [31:0] bram_dina,
	output wire [31:0] bram_douta,
	input  wire        bram_ena,
	input  wire        bram_rsta,
	input  wire [ 3:0] bram_wea,

	output reg  [ 3:0] vga_r,
	output reg  [ 3:0] vga_g,
	output reg  [ 3:0] vga_b,
	output wire        vga_hsync,
	output wire        vga_vsync
);
	reg  [16:0] bram_addrb;
	wire        bram_clkb;
	wire [31:0] bram_dinb;
	wire [31:0] bram_doutb;
	reg         bram_enb;
	wire        bram_rstb;
	wire [ 3:0] bram_web;
	
	assign bram_clkb = clk;
	assign bram_rstb = ~resetn;
	assign bram_dinb = 32'b0;
	assign bram_web  = 4'b0000;

	localparam H_VISIBLE      = 640;
	localparam H_FRONT_PORCH  = 16;
	localparam H_SYNC_PULSE   = 96;
	localparam H_BACK_PORCH   = 48;
	localparam H_TOTAL        = H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

	localparam V_VISIBLE      = 480;
	localparam V_FRONT_PORCH  = 10;
	localparam V_SYNC_PULSE   = 2;
	localparam V_BACK_PORCH   = 33;
	localparam V_TOTAL        = V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

	xpm_memory_tdpram #(
		.ADDR_WIDTH_A(17),
		.ADDR_WIDTH_B(17),
		.BYTE_WRITE_WIDTH_A(32),
		.BYTE_WRITE_WIDTH_B(32),
		.CLOCKING_MODE("independent_clock"),
		.MEMORY_PRIMITIVE("auto"),
		.MEMORY_SIZE(2457600), /* for 640x480 with 8-bit color palette */
		.RAM_DECOMP("auto"), /* NOTE: changing to "power" might fix some issues */
		.READ_DATA_WIDTH_A(32),
		.READ_DATA_WIDTH_B(32),
		.READ_LATENCY_A(2),
		.READ_LATENCY_B(2),
		.WRITE_DATA_WIDTH_A(32),
		.WRITE_DATA_WIDTH_B(32)
	)
	fb_bram (
		.douta(bram_douta),
		.addra(bram_addra),
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
