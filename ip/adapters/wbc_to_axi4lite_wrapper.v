module wb_to_axi4lite (
	input  wire        clk,
	input  wire        resetn,
	
	/* AXI4-Lite MASTER */
	output wire [31:0] M_AXI_awaddr,
	output wire [ 2:0] M_AXI_awprot,
	output wire        M_AXI_awvalid,
	input  wire        M_AXI_awready,
	
	output wire [31:0] M_AXI_wdata,
	output wire [ 3:0] M_AXI_wstrb,
	output wire        M_AXI_wvalid,
	input  wire        M_AXI_wready,
	
	input  wire [ 1:0] M_AXI_bresp,
	input  wire        M_AXI_bvalid,
	output wire        M_AXI_bready,
	
	output wire [31:0] M_AXI_araddr,
	output wire [ 2:0] M_AXI_arprot,
	output wire        M_AXI_arvalid,
	input  wire        M_AXI_arready,
	
	input  wire [31:0] M_AXI_rdata,
	input  wire [ 1:0] M_AXI_rresp,
	input  wire        M_AXI_rvalid,
	output wire        M_AXI_rready,
	
	/* Wishbone SLAVE */
	input  wire [31:0] wb_addr_i,
	input  wire [ 3:0] wb_sel_i,
	input  wire        wb_we_i,
	input  wire [31:0] wb_dat_i,
	output wire [31:0] wb_dat_o,
	input  wire        wb_cyc_i,
	input  wire        wb_stb_i,
	output wire        wb_ack_o,
	input  wire [ 2:0] wb_cti_i,
	input  wire [ 1:0] wb_bte_i
);

	wire [31:0] wbp_addr_i;
	wire [ 3:0] wbp_sel_i;
	wire        wbp_we_i;
	wire [31:0] wbp_dat_i;
	wire [31:0] wbp_dat_o;
	wire        wbp_cyc_i;
	wire        wbp_stb_i;
	wire        wbp_ack_o;
	wire        wbp_stall_o;
	wire        wbp_err_o;

	wbm2axilite  #(
		.C_AXI_ADDR_WIDTH(32)
	)
	wb_to_axi4lite_bridge (
		.i_clk         (clk),
		.i_reset       (~resetn),
		
		.i_wb_addr     (wbp_addr_i[31:2]),
		.i_wb_data     (wbp_dat_i),
		.i_wb_cyc      (wbp_cyc_i),
		.i_wb_stb      (wbp_stb_i),
		.i_wb_sel      (wbp_sel_i),
		.i_wb_we       (wbp_we_i),
		.o_wb_data     (wbp_dat_o),
		.o_wb_ack      (wbp_ack_o),
		.o_wb_stall    (wbp_stall_o),
		.o_wb_err      (wbp_err_o),
		
		.o_axi_awaddr  (M_AXI_awaddr),
		.o_axi_awprot  (M_AXI_awprot),
		.o_axi_awvalid (M_AXI_awvalid),
		.i_axi_awready (M_AXI_awready),

		.o_axi_wdata   (M_AXI_wdata),
		.o_axi_wstrb   (M_AXI_wstrb),
		.o_axi_wvalid  (M_AXI_wvalid),
		.i_axi_wready  (M_AXI_wready),

		.i_axi_bresp   (M_AXI_bresp),
		.i_axi_bvalid  (M_AXI_bvalid),
		.o_axi_bready  (M_AXI_bready),

		.o_axi_araddr  (M_AXI_araddr),
		.o_axi_arprot  (M_AXI_arprot),
		.o_axi_arvalid (M_AXI_arvalid),
		.i_axi_arready (M_AXI_arready),

		.i_axi_rdata   (M_AXI_rdata),
		.i_axi_rresp   (M_AXI_rresp),
		.i_axi_rvalid  (M_AXI_rvalid),
		.o_axi_rready  (M_AXI_rready)
    );

    wbc2pipeline #(
	    .AW(32),
	    .DW(32)
    )
    wbc2pipeline_0 (
		.i_clk(clk),
		.i_reset(~resetn),

		.i_saddr    (wb_addr_i),
		.i_sdata    (wb_dat_i),
		.o_sdata    (wb_dat_o),
		.i_ssel     (wb_sel_i),
		.i_swe      (wb_we_i),
		.i_scyc     (wb_cyc_i),
		.i_sstb     (wb_stb_i),
		.o_sack     (wb_ack_o),
		.o_serr     (),
		.i_scti     (wb_scti_i),
		.i_sbte     (wb_sbte_i),

		.o_maddr    (wbp_addr_i),
		.o_mdata    (wbp_dat_i),
		.i_mdata    (wbp_dat_o),
		.o_msel     (wbp_sel_i),
		.o_mwe      (wbp_we_i),
		.o_mcyc     (wbp_cyc_i),
		.o_mstb     (wbp_stb_i),
		.i_mstall   (wbp_stall_o),
		.i_mack     (wbp_ack_o),
		.i_merr     (wbp_err_o)
    );

endmodule
