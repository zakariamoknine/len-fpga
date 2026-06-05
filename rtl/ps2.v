module ps2 (
	input  wire          clk,
	input  wire          resetn,

	input  wire          S_AXI_LITE_awvalid,
	output wire          S_AXI_LITE_awready,
	input  wire [31:0]   S_AXI_LITE_awaddr,
	input  wire [ 2:0]   S_AXI_LITE_awprot,
	input  wire          S_AXI_LITE_wvalid,
	output wire          S_AXI_LITE_wready,
	input  wire [31:0]   S_AXI_LITE_wdata,
	input  wire [ 3:0]   S_AXI_LITE_wstrb,
	output wire          S_AXI_LITE_bvalid,
	input  wire          S_AXI_LITE_bready,
	output wire [ 1:0]   S_AXI_LITE_bresp,
	input  wire          S_AXI_LITE_arvalid,
	output wire          S_AXI_LITE_arready,
	input  wire [31:0]   S_AXI_LITE_araddr,
	input  wire [ 2:0]   S_AXI_LITE_arprot,
	output wire          S_AXI_LITE_rvalid,
	input  wire          S_AXI_LITE_rready,
	output wire [31:0]   S_AXI_LITE_rdata,
	output wire [ 1:0]   S_AXI_LITE_rresp,

	output wire          ps2_intr,
	inout  wire          ps2_data,
	inout  wire          ps2_clk
);

	wire ps2_data_i, ps2_data_o, ps2_data_t;
	wire ps2_clk_i,  ps2_clk_o,  ps2_clk_t;

	IOBUF #(
		.DRIVE(12),
		.IBUF_LOW_PWR("FALSE"),
		.IOSTANDARD("LVCMOS33"),
		.SLEW("FAST")
	) PS2_DATA_IOBUF_instance (
		.O  (ps2_data_i),
		.IO (ps2_data),
		.I  (ps2_data_o),
		.T  (ps2_data_t)
	);

	IOBUF #(
		.DRIVE(12),
		.IBUF_LOW_PWR("FALSE"),
		.IOSTANDARD("LVCMOS33"),
		.SLEW("FAST")
	) PS2_CLK_IOBUF_instance (
		.O  (ps2_clk_i),
		.IO (ps2_clk),
		.I  (ps2_clk_o),
		.T  (ps2_clk_t)
	);


	axi_ps2_v1_0 #(
		.C_S_AXI_DATA_WIDTH(32),
		.C_S_AXI_ADDR_WIDTH(5)
	) ps2_instance (
		.PS2_Data_I    (ps2_data_i),
		.PS2_Data_O    (ps2_data_o),
		.PS2_Data_T    (ps2_data_t),
		.PS2_Clk_I     (ps2_clk_i),
		.PS2_Clk_O     (ps2_clk_o),
		.PS2_Clk_T     (ps2_clk_t),
		.PS2_interrupt (ps2_intr),

		.S_AXI_aclk    (clk),
		.S_AXI_aresetn (resetn),
		.S_AXI_awaddr  (S_AXI_LITE_awaddr[4:0]),
		.S_AXI_awprot  (S_AXI_LITE_awprot),
		.S_AXI_awvalid (S_AXI_LITE_awvalid),
		.S_AXI_awready (S_AXI_LITE_awready),
		.S_AXI_wdata   (S_AXI_LITE_wdata),
		.S_AXI_wstrb   (S_AXI_LITE_wstrb),
		.S_AXI_wvalid  (S_AXI_LITE_wvalid),
		.S_AXI_wready  (S_AXI_LITE_wready),
		.S_AXI_bresp   (S_AXI_LITE_bresp),
		.S_AXI_bvalid  (S_AXI_LITE_bvalid),
		.S_AXI_bready  (S_AXI_LITE_bready),
		.S_AXI_araddr  (S_AXI_LITE_araddr[4:0]),
		.S_AXI_arprot  (S_AXI_LITE_arprot),
		.S_AXI_arvalid (S_AXI_LITE_arvalid),
		.S_AXI_arready (S_AXI_LITE_arready),
		.S_AXI_rdata   (S_AXI_LITE_rdata),
		.S_AXI_rresp   (S_AXI_LITE_rresp),
		.S_AXI_rvalid  (S_AXI_LITE_rvalid),
		.S_AXI_rready  (S_AXI_LITE_rready)
	);
	
endmodule
