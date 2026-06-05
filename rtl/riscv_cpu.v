`timescale 1ns / 1ps

module riscv_cpu (
	input  wire          clk,
	input  wire          reset,
	
	output wire          AXI_DC_awvalid,
	input  wire          AXI_DC_awready,
	output wire [31:0]   AXI_DC_awaddr,
	output wire [ 7:0]   AXI_DC_awlen,
	output wire [ 2:0]   AXI_DC_awsize,
	output wire [ 1:0]   AXI_DC_awburst,
	output wire [ 3:0]   AXI_DC_awcache,
	output wire [ 2:0]   AXI_DC_awprot,

	output wire          AXI_DC_wvalid,
	input  wire          AXI_DC_wready,
	output wire [63:0]   AXI_DC_wdata,
	output wire [ 7:0]   AXI_DC_wstrb,
	output wire          AXI_DC_wlast,

	input  wire          AXI_DC_bvalid,
	output wire          AXI_DC_bready,
	input  wire [ 1:0]   AXI_DC_bresp,

	output wire          AXI_DC_arvalid,
	input  wire          AXI_DC_arready,
	output wire [31:0]   AXI_DC_araddr,
	output wire [ 7:0]   AXI_DC_arlen,
	output wire [ 2:0]   AXI_DC_arsize,
	output wire [ 1:0]   AXI_DC_arburst,
	output wire [ 3:0]   AXI_DC_arcache,
	output wire [ 2:0]   AXI_DC_arprot,

	input  wire          AXI_DC_rvalid,
	output wire          AXI_DC_rready,
	input  wire [63:0]   AXI_DC_rdata,
	input  wire [ 1:0]   AXI_DC_rresp,
	input  wire          AXI_DC_rlast,

	output wire          AXI_IC_arvalid,
	input  wire          AXI_IC_arready,
	output wire [31:0]   AXI_IC_araddr,
	output wire [ 7:0]   AXI_IC_arlen,
	output wire [ 2:0]   AXI_IC_arsize,
	output wire [ 1:0]   AXI_IC_arburst,
	output wire [ 3:0]   AXI_IC_arcache,
	output wire [ 2:0]   AXI_IC_arprot,

	input  wire          AXI_IC_rvalid,
	output wire          AXI_IC_rready,
	input  wire [63:0]   AXI_IC_rdata,
	input  wire [ 1:0]   AXI_IC_rresp,
	input  wire          AXI_IC_rlast,

	output wire          AXI_DP_awvalid,
	input  wire          AXI_DP_awready,
	output wire [31:0]   AXI_DP_awaddr,
	output wire [ 2:0]   AXI_DP_awsize,
	output wire [ 3:0]   AXI_DP_awcache,
	output wire [ 2:0]   AXI_DP_awprot,

	output wire          AXI_DP_wvalid,
	input  wire          AXI_DP_wready,
	output wire [63:0]   AXI_DP_wdata,
	output wire [ 7:0]   AXI_DP_wstrb,
	output wire          AXI_DP_wlast,

	input  wire          AXI_DP_bvalid,
	output wire          AXI_DP_bready,
	input  wire [ 1:0]   AXI_DP_bresp,

	output wire          AXI_DP_arvalid,
	input  wire          AXI_DP_arready,
	output wire [31:0]   AXI_DP_araddr,
	output wire [ 2:0]   AXI_DP_arsize,
	output wire [ 3:0]   AXI_DP_arcache,
	output wire [ 2:0]   AXI_DP_arprot,

	input  wire          AXI_DP_rvalid,
	output wire          AXI_DP_rready,
	input  wire [63:0]   AXI_DP_rdata,
	input  wire [ 1:0]   AXI_DP_rresp,
	input  wire          AXI_DP_rlast,

	input  wire          timer_intr,
	input  wire          sftwr_intr,
	input  wire          m_extrnl_intr,
	input  wire          s_extrnl_intr
);

	reg [63:0] ticks;

	always @(posedge clk) begin
		if (reset) begin
			ticks <= 0;
		end else begin
			ticks <= ticks + 1;
		end
	end

	VexiiRiscv cpu_instance (
		.clk(clk),
		.reset(reset),

		.LsuL1Axi4Plugin_logic_axi_aw_valid(AXI_DC_awvalid),
		.LsuL1Axi4Plugin_logic_axi_aw_ready(AXI_DC_awready),
		.LsuL1Axi4Plugin_logic_axi_aw_payload_addr(AXI_DC_awaddr),
		.LsuL1Axi4Plugin_logic_axi_aw_payload_len(AXI_DC_awlen),
		.LsuL1Axi4Plugin_logic_axi_aw_payload_size(AXI_DC_awsize),
		.LsuL1Axi4Plugin_logic_axi_aw_payload_burst(AXI_DC_awburst),
		.LsuL1Axi4Plugin_logic_axi_aw_payload_cache(AXI_DC_awcache),
		.LsuL1Axi4Plugin_logic_axi_aw_payload_prot(AXI_DC_awprot),

		.LsuL1Axi4Plugin_logic_axi_w_valid(AXI_DC_wvalid),
		.LsuL1Axi4Plugin_logic_axi_w_ready(AXI_DC_wready),
		.LsuL1Axi4Plugin_logic_axi_w_payload_data(AXI_DC_wdata),
		.LsuL1Axi4Plugin_logic_axi_w_payload_strb(AXI_DC_wstrb),
		.LsuL1Axi4Plugin_logic_axi_w_payload_last(AXI_DC_wlast),

		.LsuL1Axi4Plugin_logic_axi_b_valid(AXI_DC_bvalid),
		.LsuL1Axi4Plugin_logic_axi_b_ready(AXI_DC_bready),
		.LsuL1Axi4Plugin_logic_axi_b_payload_resp(AXI_DC_bresp),

		.LsuL1Axi4Plugin_logic_axi_ar_valid(AXI_DC_arvalid),
		.LsuL1Axi4Plugin_logic_axi_ar_ready(AXI_DC_arready),
		.LsuL1Axi4Plugin_logic_axi_ar_payload_addr(AXI_DC_araddr),
		.LsuL1Axi4Plugin_logic_axi_ar_payload_len(AXI_DC_arlen),
		.LsuL1Axi4Plugin_logic_axi_ar_payload_size(AXI_DC_arsize),
		.LsuL1Axi4Plugin_logic_axi_ar_payload_burst(AXI_DC_arburst),
		.LsuL1Axi4Plugin_logic_axi_ar_payload_cache(AXI_DC_arcache),
		.LsuL1Axi4Plugin_logic_axi_ar_payload_prot(AXI_DC_arprot),

		.LsuL1Axi4Plugin_logic_axi_r_valid(AXI_DC_rvalid),
		.LsuL1Axi4Plugin_logic_axi_r_ready(AXI_DC_rready),
		.LsuL1Axi4Plugin_logic_axi_r_payload_data(AXI_DC_rdata),
		.LsuL1Axi4Plugin_logic_axi_r_payload_resp(AXI_DC_rresp),
		.LsuL1Axi4Plugin_logic_axi_r_payload_last(AXI_DC_rlast),

		.FetchL1Axi4Plugin_logic_axi_ar_valid(AXI_IC_arvalid),
		.FetchL1Axi4Plugin_logic_axi_ar_ready(AXI_IC_arready),
		.FetchL1Axi4Plugin_logic_axi_ar_payload_addr(AXI_IC_araddr),
		.FetchL1Axi4Plugin_logic_axi_ar_payload_len(AXI_IC_arlen),
		.FetchL1Axi4Plugin_logic_axi_ar_payload_size(AXI_IC_arsize),
		.FetchL1Axi4Plugin_logic_axi_ar_payload_burst(AXI_IC_arburst),
		.FetchL1Axi4Plugin_logic_axi_ar_payload_cache(AXI_IC_arcache),
		.FetchL1Axi4Plugin_logic_axi_ar_payload_prot(AXI_IC_arprot),

		.FetchL1Axi4Plugin_logic_axi_r_valid(AXI_IC_rvalid),
		.FetchL1Axi4Plugin_logic_axi_r_ready(AXI_IC_rready),
		.FetchL1Axi4Plugin_logic_axi_r_payload_data(AXI_IC_rdata),
		.FetchL1Axi4Plugin_logic_axi_r_payload_resp(AXI_IC_rresp),
		.FetchL1Axi4Plugin_logic_axi_r_payload_last(AXI_IC_rlast),

		.LsuCachelessAxi4Plugin_logic_axi_aw_valid(AXI_DP_awvalid),
		.LsuCachelessAxi4Plugin_logic_axi_aw_ready(AXI_DP_awready),
		.LsuCachelessAxi4Plugin_logic_axi_aw_payload_addr(AXI_DP_awaddr),
		.LsuCachelessAxi4Plugin_logic_axi_aw_payload_size(AXI_DP_awsize),
		.LsuCachelessAxi4Plugin_logic_axi_aw_payload_cache(AXI_DP_awcache),
		.LsuCachelessAxi4Plugin_logic_axi_aw_payload_prot(AXI_DP_awprot),

		.LsuCachelessAxi4Plugin_logic_axi_w_valid(AXI_DP_wvalid),
		.LsuCachelessAxi4Plugin_logic_axi_w_ready(AXI_DP_wready),
		.LsuCachelessAxi4Plugin_logic_axi_w_payload_data(AXI_DP_wdata),
		.LsuCachelessAxi4Plugin_logic_axi_w_payload_strb(AXI_DP_wstrb),
		.LsuCachelessAxi4Plugin_logic_axi_w_payload_last(AXI_DP_wlast),

		.LsuCachelessAxi4Plugin_logic_axi_b_valid(AXI_DP_bvalid),
		.LsuCachelessAxi4Plugin_logic_axi_b_ready(AXI_DP_bready),
		.LsuCachelessAxi4Plugin_logic_axi_b_payload_resp(AXI_DP_bresp),

		.LsuCachelessAxi4Plugin_logic_axi_ar_valid(AXI_DP_arvalid),
		.LsuCachelessAxi4Plugin_logic_axi_ar_ready(AXI_DP_arready),
		.LsuCachelessAxi4Plugin_logic_axi_ar_payload_addr(AXI_DP_araddr),
		.LsuCachelessAxi4Plugin_logic_axi_ar_payload_size(AXI_DP_arsize),
		.LsuCachelessAxi4Plugin_logic_axi_ar_payload_cache(AXI_DP_arcache),
		.LsuCachelessAxi4Plugin_logic_axi_ar_payload_prot(AXI_DP_arprot),

		.LsuCachelessAxi4Plugin_logic_axi_r_valid(AXI_DP_rvalid),
		.LsuCachelessAxi4Plugin_logic_axi_r_ready(AXI_DP_rready),
		.LsuCachelessAxi4Plugin_logic_axi_r_payload_data(AXI_DP_rdata),
		.LsuCachelessAxi4Plugin_logic_axi_r_payload_resp(AXI_DP_rresp),
		.LsuCachelessAxi4Plugin_logic_axi_r_payload_last(AXI_DP_rlast),

		.PrivilegedPlugin_logic_rdtime(ticks),
		.PrivilegedPlugin_logic_harts_0_int_m_timer(timer_intr),
		.PrivilegedPlugin_logic_harts_0_int_m_software(sftwr_intr),
		.PrivilegedPlugin_logic_harts_0_int_m_external(m_extrnl_intr),
		.PrivilegedPlugin_logic_harts_0_int_s_external(s_extrnl_intr)
	);

endmodule
