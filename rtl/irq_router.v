module irq_router (
	input  wire uart_irq,

	output wire [31:0] sources
);

	assign sources[0] = 1'b0;
	
	assign sources[1] = uart_irq;

	assign sources[2]  = 1'b0;
	assign sources[3]  = 1'b0;
	assign sources[4]  = 1'b0;
	assign sources[5]  = 1'b0;
	assign sources[6]  = 1'b0;
	assign sources[7]  = 1'b0;
	assign sources[8]  = 1'b0;
	assign sources[9]  = 1'b0;
	assign sources[10] = 1'b0;
	assign sources[11] = 1'b0;
	assign sources[12] = 1'b0;
	assign sources[13] = 1'b0;
	assign sources[14] = 1'b0;
	assign sources[15] = 1'b0;
	assign sources[16] = 1'b0;
	assign sources[17] = 1'b0;
	assign sources[18] = 1'b0;
	assign sources[19] = 1'b0;
	assign sources[20] = 1'b0;
	assign sources[21] = 1'b0;
	assign sources[22] = 1'b0;
	assign sources[23] = 1'b0;
	assign sources[24] = 1'b0;
	assign sources[25] = 1'b0;
	assign sources[26] = 1'b0;
	assign sources[27] = 1'b0;
	assign sources[28] = 1'b0;
	assign sources[29] = 1'b0;
	assign sources[30] = 1'b0;
	assign sources[31] = 1'b0;

endmodule
