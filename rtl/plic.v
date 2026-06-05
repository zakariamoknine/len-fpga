module plic (
	input  wire          clk,
	input  wire          resetn,

	input  wire          S_AXI_awvalid,
	output wire          S_AXI_awready,
	input  wire [31:0]   S_AXI_awaddr,
	input  wire [ 2:0]   S_AXI_awprot,
	input  wire          S_AXI_wvalid,
	output wire          S_AXI_wready,
	input  wire [31:0]   S_AXI_wdata,
	input  wire [ 3:0]   S_AXI_wstrb,
	output wire          S_AXI_bvalid,
	input  wire          S_AXI_bready,
	output wire [ 1:0]   S_AXI_bresp,
	input  wire          S_AXI_arvalid,
	output wire          S_AXI_arready,
	input  wire [31:0]   S_AXI_araddr,
	input  wire [ 2:0]   S_AXI_arprot,
	output wire          S_AXI_rvalid,
	input  wire          S_AXI_rready,
	output wire [31:0]   S_AXI_rdata,
	output wire [ 1:0]   S_AXI_rresp,

	input  wire [31:0]   sources,
	output wire          m_extrnl_intr,
	output wire          s_extrnl_intr
);

	wire [1:0] targets_internal;

	assign m_extrnl_intr = targets_internal[0];
	assign s_extrnl_intr = targets_internal[1];

	AxiLite4Plic plic_instance (
		.clk(clk),
		.reset(~resetn),
		.io_bus_aw_valid(S_AXI_awvalid),
		.io_bus_aw_ready(S_AXI_awready),
		.io_bus_aw_payload_addr(S_AXI_awaddr[21:0]),
		.io_bus_aw_payload_prot(S_AXI_awprot),
		.io_bus_w_valid(S_AXI_wvalid),
		.io_bus_w_ready(S_AXI_wready),
		.io_bus_w_payload_data(S_AXI_wdata),
		.io_bus_w_payload_strb(S_AXI_wstrb),
		.io_bus_b_valid(S_AXI_bvalid),
		.io_bus_b_ready(S_AXI_bready),
		.io_bus_b_payload_resp(S_AXI_bresp),
		.io_bus_ar_valid(S_AXI_arvalid),
		.io_bus_ar_ready(S_AXI_arready),
		.io_bus_ar_payload_addr(S_AXI_araddr[21:0]),
		.io_bus_ar_payload_prot(S_AXI_arprot),
		.io_bus_r_valid(S_AXI_rvalid),
		.io_bus_r_ready(S_AXI_rready),
		.io_bus_r_payload_data(S_AXI_rdata),
		.io_bus_r_payload_resp(S_AXI_rresp),
		.io_sources(sources),
		.io_targets(targets_internal)
	);

endmodule
