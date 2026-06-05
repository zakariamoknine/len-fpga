module axi4lite_to_wb (
	input  wire        clk,
	input  wire        resetn,
	
	/* AXI4-Lite SLAVE */
	input  wire [31:0] S_AXI_awaddr,
	input  wire [ 2:0] S_AXI_awprot,
	input  wire        S_AXI_awvalid,
	output wire        S_AXI_awready,
	
	input  wire [31:0] S_AXI_wdata,
	input  wire [ 3:0] S_AXI_wstrb,
	input  wire        S_AXI_wvalid,
	output wire        S_AXI_wready,
	
	output wire [ 1:0] S_AXI_bresp,
	output wire        S_AXI_bvalid,
	input  wire        S_AXI_bready,
	
	input  wire [31:0] S_AXI_araddr,
	input  wire [ 2:0] S_AXI_arprot,
	input  wire        S_AXI_arvalid,
	output wire        S_AXI_arready,
	
	output wire [31:0] S_AXI_rdata,
	output wire [ 1:0] S_AXI_rresp,
	output wire        S_AXI_rvalid,
	input  wire        S_AXI_rready,
	
	/* Wishbone MASTER */
	output wire [ 7:0] wb_addr_o,
	output wire [31:0] wb_dat_o,
	input  wire [31:0] wb_dat_i,
	output wire [ 3:0] wb_sel_o,
	output wire        wb_we_o,
	output wire        wb_cyc_o,
	output wire        wb_stb_o,
	input  wire        wb_ack_i
);

	wire [25:0] wbp_addr_o;
	wire [31:0] wbp_dat_o;
	wire [31:0] wbp_dat_i;
	wire [ 3:0] wbp_sel_o;
	wire        wbp_we_o;
	wire        wbp_cyc_o;
	wire        wbp_stb_o;
	wire        wbp_ack_i;
	wire        wbp_err_o;
	wire        wbp_stall_o;

	wire [11:0] wb_addr_full_o;
	assign wb_addr_o = {wb_addr_full_o[5:0], 2'b00};
	
	axlite2wbsp #(
		.C_AXI_DATA_WIDTH(32),
		.C_AXI_ADDR_WIDTH(28)
	) axi4lite_to_wb_bridge (
		.i_clk         (clk),
		.i_axi_reset_n (resetn),
		
		/* AXI4-lite SLAVE */
		.i_axi_awaddr  (S_AXI_awaddr[27:0]),
		.i_axi_awprot  (S_AXI_awprot),
		.i_axi_awvalid (S_AXI_awvalid),
		.o_axi_awready (S_AXI_awready),

		.i_axi_wdata   (S_AXI_wdata),
		.i_axi_wstrb   (S_AXI_wstrb),
		.i_axi_wvalid  (S_AXI_wvalid),
		.o_axi_wready  (S_AXI_wready),

		.o_axi_bresp   (S_AXI_bresp),
		.o_axi_bvalid  (S_AXI_bvalid),
		.i_axi_bready  (S_AXI_bready),

		.i_axi_araddr  (S_AXI_araddr[27:0]),
		.i_axi_arprot  (S_AXI_arprot),
		.i_axi_arvalid (S_AXI_arvalid),
		.o_axi_arready (S_AXI_arready),

		.o_axi_rdata   (S_AXI_rdata),
		.o_axi_rresp   (S_AXI_rresp),
		.o_axi_rvalid  (S_AXI_rvalid),
		.i_axi_rready  (S_AXI_rready),
		
		/* Wishbone MASTER */
		.o_reset      (),
		.o_wb_addr    (wbp_addr_o),
		.o_wb_data    (wbp_dat_o),
		.i_wb_data    (wbp_dat_i),
		.o_wb_sel     (wbp_sel_o),
		.o_wb_we      (wbp_we_o),
		.o_wb_cyc     (wbp_cyc_o),
		.o_wb_stb     (wbp_stb_o),
		.i_wb_ack     (wbp_ack_i),
		.i_wb_err     (wbp_err_o),
		.i_wb_stall   (wbp_stall_o)
	);

	wbp2classic #(
		.AW(12),
		.DW(32)
	)
	wbp2classic_0 (
		.i_clk(clk),
		.i_reset(~resetn),

		.i_saddr    (wbp_addr_o),
		.i_sdata    (wbp_dat_o),
		.o_sdata    (wbp_dat_i),
		.i_ssel     (wbp_sel_o),
		.i_swe      (wbp_we_o),
		.i_scyc     (wbp_cyc_o),
		.i_sstb     (wbp_stb_o),
		.o_sack     (wbp_ack_i),
		.o_serr     (wbp_err_o),
		.o_sstall   (wbp_stall_o),

		.o_maddr    (wb_addr_full_o),
		.o_mdata    (wb_dat_o),
		.i_mdata    (wb_dat_i),
		.o_msel     (wb_sel_o),
		.o_mwe      (wb_we_o),
		.o_mcyc     (wb_cyc_o),
		.o_mstb     (wb_stb_o),
		.i_mack     (wb_ack_i),
		.i_merr     (1'b0)
	);

endmodule
