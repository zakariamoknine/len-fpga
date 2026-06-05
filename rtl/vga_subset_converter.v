module vga_subset_converter (
	input  wire       hsync_i,
	input  wire       vsync_i,
	input  wire       de_i,
	input  wire [5:0] r_i,
	input  wire [5:0] g_i,
	input  wire [5:0] b_i,
	
	output wire       hsync_o,
	output wire       vsync_o,
	output wire [3:0] r_o,
	output wire [3:0] g_o,
	output wire [3:0] b_o
);

	assign hsync_o = hsync_i;
	assign vsync_o = vsync_i;

	assign r_o = de_i ? r_i[5:2] : 4'b0000;
	assign g_o = de_i ? g_i[5:2] : 4'b0000;
	assign b_o = de_i ? b_i[5:2] : 4'b0000;

endmodule
