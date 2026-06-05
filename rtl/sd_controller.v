`timescale 1 ns / 1 ps

module sd_controller (
	/* Wishbone common */
	input  wire        wb_clk_i,
	input  wire        wb_rstn_i,

	/* Wishbone SLAVE PORT */
	input  wire [31:0] wb_dat_i,
	output wire [31:0] wb_dat_o,
	input  wire [ 7:0] wb_adr_i,
	input  wire [ 3:0] wb_sel_i,
	input  wire        wb_we_i,
	input  wire        wb_cyc_i,
	input  wire        wb_stb_i,
	output wire        wb_ack_o,

	/* Wishbone MASTER PORT */
	output wire [31:0] m_wb_adr_o,
	output wire [ 3:0] m_wb_sel_o,
	output wire        m_wb_we_o,
	input  wire [31:0] m_wb_dat_i,
	output wire [31:0] m_wb_dat_o,
	output wire        m_wb_cyc_o,
	output wire        m_wb_stb_o,
	input  wire        m_wb_ack_i,
	output wire [ 2:0] m_wb_cti_o,
	output wire [ 1:0] m_wb_bte_o,

	/* SD card signals */
	output wire        sd_reset,
	//input  wire        sd_cd,
	output wire        sd_sck,
	inout  wire        sd_cmd,
	inout  wire [ 3:0] sd_dat,

	/* Interrupts */
	output wire        cmd_intr,
	output wire        data_intr
);

	wire [ 3:0] sd_dat_dat_i;
	wire [ 3:0] sd_dat_out_o;
	wire        sd_dat_oe_o;
	wire        sd_cmd_dat_i;
	wire        sd_cmd_out_o;
	wire        sd_cmd_oe_o;
	wire        sd_clk_i_pad;
	wire        sd_clk_o_pad;
	wire        sd_clk_o_pad_bufg;

	/* 
	 * Nexys A7-100T Manual Reference requires setting sd_reset to 0
	 *
	 * https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual
	 */
	assign sd_reset = 1'b0;

	assign sd_clk_i_pad = wb_clk_i;

	/*
	 * Generate a tri-state buffer for the SD_CMD inout
	 */
	IOBUF #(
		.DRIVE(12),
		.IBUF_LOW_PWR("FALSE"),
		.IOSTANDARD("LVCMOS33"),
		.SLEW("FAST")
	) IOBUF_SD_CMD_instance (
		.O  (sd_cmd_dat_i),
		.IO (sd_cmd),
		.I  (sd_cmd_out_o),
		.T  (~sd_cmd_oe_o)
	);

	/*
	 * Generate 4 tri-state buffers for the SD_DAT[3:0] inout
	 */
	generate
		genvar i;
		for (i = 0; i < 4; i = i + 1) begin : SD_DAT_IOBUF_GEN
			IOBUF #(
				.DRIVE(12),
				.IBUF_LOW_PWR("FALSE"),
				.IOSTANDARD("LVCMOS33"),
				.SLEW("FAST")
			) IOBUF_SD_DAT_instance (
				.O  (sd_dat_dat_i[i]),
				.IO (sd_dat[i]),
				.I  (sd_dat_out_o[i]),
				.T  (~sd_dat_oe_o)
			);
		end
	endgenerate

	/*
	 * Add BUFG to avoid clock skew
	 */
	BUFG BUFG_SD_SCK_instance (
		.I (sd_clk_o_pad),
		.O (sd_clk_o_pad_bufg)
	);
	
	/*
	 * Add ODDR to drive SD_SCK, use OPPOSITE_EDGE
	 * to give the SD card a full half-cycle to
	 * sample the stable data before the next
	 * transition
	 */
	ODDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"),
		.INIT(1'b0),
		.SRTYPE("SYNC")
	) ODDR_SD_SCK_instance (
		.Q  (sd_sck),
		.C  (sd_clk_o_pad_bufg),
		.CE (1'b1),
		.D1 (1'b1),
		.D2 (1'b0),
		.R  (1'b0),
		.S  (1'b0)
	);

	sdc_controller sdc_controller_instance (
		.wb_clk_i        (wb_clk_i),
		.wb_rst_i        (~wb_rstn_i),

		.wb_dat_i        (wb_dat_i),
		.wb_dat_o        (wb_dat_o),
		.wb_adr_i        (wb_adr_i),
		.wb_sel_i        (wb_sel_i),
		.wb_we_i         (wb_we_i ),
		.wb_cyc_i        (wb_cyc_i),
		.wb_stb_i        (wb_stb_i),
		.wb_ack_o        (wb_ack_o),

		.m_wb_adr_o      (m_wb_adr_o),
		.m_wb_sel_o      (m_wb_sel_o),
		.m_wb_we_o       (m_wb_we_o ),
		.m_wb_dat_i      (m_wb_dat_i),
		.m_wb_dat_o      (m_wb_dat_o),
		.m_wb_cyc_o      (m_wb_cyc_o),
		.m_wb_stb_o      (m_wb_stb_o),
		.m_wb_ack_i      (m_wb_ack_i),
		.m_wb_cti_o      (m_wb_cti_o),
		.m_wb_bte_o      (m_wb_bte_o),

		.sd_dat_dat_i    (sd_dat_dat_i),
		.sd_dat_out_o    (sd_dat_out_o),
		.sd_dat_oe_o     (sd_dat_oe_o ),
		.sd_cmd_dat_i    (sd_cmd_dat_i),
		.sd_cmd_out_o    (sd_cmd_out_o),
		.sd_cmd_oe_o     (sd_cmd_oe_o ),
		.sd_clk_o_pad    (sd_clk_o_pad),
		.sd_clk_i_pad    (sd_clk_i_pad),

		.int_cmd         (cmd_intr ),
		.int_data        (data_intr)
	);

endmodule
