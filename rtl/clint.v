`timescale 1 ns / 1 ps

module clint #(
	parameter integer AXI_DATA_WIDTH = 32,
	parameter integer AXI_ADDR_WIDTH = 16
) (
	output wire sftwr_intr,
	output wire timer_intr,

	input  wire aclk,
	input  wire aresetn,
	input  wire [AXI_ADDR_WIDTH-1 : 0] S_AXI_awaddr,
	input  wire [2 : 0] S_AXI_awprot,
	input  wire S_AXI_awvalid,
	output wire S_AXI_awready,
	input  wire [AXI_DATA_WIDTH-1 : 0] S_AXI_wdata,
	input  wire [(AXI_DATA_WIDTH/8)-1 : 0] S_AXI_wstrb,
	input  wire S_AXI_wvalid,
	output wire S_AXI_wready,
	output wire [1 : 0] S_AXI_bresp,
	output wire S_AXI_bvalid,
	input  wire S_AXI_bready,
	input  wire [AXI_ADDR_WIDTH-1 : 0] S_AXI_araddr,
	input  wire [2 : 0] S_AXI_arprot,
	input  wire S_AXI_arvalid,
	output wire S_AXI_arready,
	output wire [AXI_DATA_WIDTH-1 : 0] S_AXI_rdata,
	output wire [1 : 0] S_AXI_rresp,
	output wire S_AXI_rvalid,
	input  wire S_AXI_rready
);
	clint_impl # ( 
		.AXI_DATA_WIDTH(32),
		.AXI_ADDR_WIDTH(16)
	) clint_impl_instance (
		.S_AXI_ACLK(aclk),
		.S_AXI_ARESETN(aresetn),
		.S_AXI_AWADDR(S_AXI_awaddr),
		.S_AXI_AWPROT(S_AXI_awprot),
		.S_AXI_AWVALID(S_AXI_awvalid),
		.S_AXI_AWREADY(S_AXI_awready),
		.S_AXI_WDATA(S_AXI_wdata),
		.S_AXI_WSTRB(S_AXI_wstrb),
		.S_AXI_WVALID(S_AXI_wvalid),
		.S_AXI_WREADY(S_AXI_wready),
		.S_AXI_BRESP(S_AXI_bresp),
		.S_AXI_BVALID(S_AXI_bvalid),
		.S_AXI_BREADY(S_AXI_bready),
		.S_AXI_ARADDR(S_AXI_araddr),
		.S_AXI_ARPROT(S_AXI_arprot),
		.S_AXI_ARVALID(S_AXI_arvalid),
		.S_AXI_ARREADY(S_AXI_arready),
		.S_AXI_RDATA(S_AXI_rdata),
		.S_AXI_RRESP(S_AXI_rresp),
		.S_AXI_RVALID(S_AXI_rvalid),
		.S_AXI_RREADY(S_AXI_rready),
	
		.sftwr_irq(sftwr_intr),
		.timer_irq(timer_intr)
	);

endmodule

module clint_impl #(
	parameter integer AXI_DATA_WIDTH = 32,
	parameter integer AXI_ADDR_WIDTH = 16
) (
	output wire sftwr_irq,
	output wire timer_irq,

	input  wire S_AXI_ACLK,
	input  wire S_AXI_ARESETN,
	input  wire [AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
	input  wire [2 : 0] S_AXI_AWPROT,
	input  wire S_AXI_AWVALID,
	output wire S_AXI_AWREADY,
	input  wire [AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
	input  wire [(AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
	input  wire S_AXI_WVALID,
	output wire S_AXI_WREADY,
	output wire [1 : 0] S_AXI_BRESP,
	output wire S_AXI_BVALID,
	input  wire S_AXI_BREADY,
	input  wire [AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
	input  wire [2 : 0] S_AXI_ARPROT,
	input  wire S_AXI_ARVALID,
	output wire S_AXI_ARREADY,
	output wire [AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
	output wire [1 : 0] S_AXI_RRESP,
	output wire S_AXI_RVALID,
	input  wire S_AXI_RREADY
);

	reg [AXI_ADDR_WIDTH-1 : 0] axi_awaddr;
	reg axi_awready;
	reg axi_wready;
	reg [1 : 0] axi_bresp;
	reg axi_bvalid;
	reg [AXI_ADDR_WIDTH-1 : 0] axi_araddr;
	reg axi_arready;
	reg [1 : 0] axi_rresp;
	reg axi_rvalid;

	localparam integer ADDR_LSB = (AXI_DATA_WIDTH/32) + 1;
	
	/* Address viewport size, starting from ADDR_LSB=2, [X : 2] */
	localparam integer OPT_MEM_ADDR_BITS = 13;

	reg  [63:0] mtime;

	/* Device Control Registers */
	reg  [AXI_DATA_WIDTH-1:0]	msip;
	reg  [AXI_DATA_WIDTH-1:0]	mtimecmp_l;
	reg  [AXI_DATA_WIDTH-1:0]	mtimecmp_h;
	wire [AXI_DATA_WIDTH-1:0]	mtime_l;
	wire [AXI_DATA_WIDTH-1:0]	mtime_h;
	integer	 byte_index;

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;

	reg [1:0] state_write;
	reg [1:0] state_read;

	/* AXI Write FSM */
	localparam Idle = 2'b00,Raddr = 2'b10,Rdata = 2'b11 ,Waddr = 2'b10,Wdata = 2'b11;
	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			axi_awready <= 0;
			axi_wready <= 0;
			axi_bvalid <= 0;
			axi_bresp <= 0;
			axi_awaddr <= 0;
			state_write <= Idle;
		end else begin
			case(state_write)
			Idle: begin
				if(S_AXI_ARESETN == 1'b1) begin
					axi_awready <= 1'b1;
					axi_wready <= 1'b1;
					state_write <= Waddr;
				end else state_write <= state_write;
			end
			Waddr: begin
				if (S_AXI_AWVALID && S_AXI_AWREADY) begin
					axi_awaddr <= S_AXI_AWADDR;
					if(S_AXI_WVALID) begin
						axi_awready <= 1'b1;
						state_write <= Waddr;
						axi_bvalid <= 1'b1;
					end else begin
						axi_awready <= 1'b0;
						state_write <= Wdata;
						if (S_AXI_BREADY && axi_bvalid) axi_bvalid <= 1'b0;
					end
				end else begin
					state_write <= state_write;
					if (S_AXI_BREADY && axi_bvalid) axi_bvalid <= 1'b0;
				end
			end
			Wdata: begin
				if (S_AXI_WVALID) begin
					state_write <= Waddr;
					axi_bvalid <= 1'b1;
					axi_awready <= 1'b1;
				end else begin
					state_write <= state_write;
					if (S_AXI_BREADY && axi_bvalid) axi_bvalid <= 1'b0;
				end
			end
			endcase
		end
	end

	always @( posedge S_AXI_ACLK ) begin
		if ( S_AXI_ARESETN == 1'b0 ) begin
			/* 
			 * Reset all Device Control Registers 
			 * Bewary of registers that are driven from 2 sources
			 */
			msip <= 0;
			mtimecmp_l <= 0;
			mtimecmp_h <= 0;
		end else begin
			if (S_AXI_WVALID) begin
				/*
				 * Write logic, make sure you have the right
				 * OPT_MEM_ADDR_BITS value, and make sure the
				 * case values have the right address which is
				 * contained in the OPT_MEM_ADDR_BITS viewport
				 * [X : 2], you can add as many registers as
				 * you want 
				 */
				case ( (S_AXI_AWVALID) ? S_AXI_AWADDR[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] : 
					axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
				14'b0000000000000:
					for ( byte_index = 0; byte_index <= (AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						if ( S_AXI_WSTRB[byte_index] == 1 ) begin
							msip[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						end
				14'b01000000000000:
					for ( byte_index = 0; byte_index <= (AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						if ( S_AXI_WSTRB[byte_index] == 1 ) begin
							mtimecmp_l[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						end
				14'b01000000000001:
					for ( byte_index = 0; byte_index <= (AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
						if ( S_AXI_WSTRB[byte_index] == 1 ) begin
							mtimecmp_h[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						end
				default : begin
					/* Write default value of all registers */
					msip <= msip;
					mtimecmp_l <= mtimecmp_l;
					mtimecmp_h <= mtimecmp_h;
				end
				endcase
			end
		end
	end

	/* AXI Read FSM */
	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			axi_arready <= 1'b0;
			axi_rvalid <= 1'b0;
			axi_rresp <= 1'b0;
			state_read <= Idle;
		end else begin
			case(state_read)
			Idle: begin
				if (S_AXI_ARESETN == 1'b1) begin
					state_read <= Raddr;
					axi_arready <= 1'b1;
				end
				else state_read <= state_read;
			end
			Raddr: begin
				if (S_AXI_ARVALID && S_AXI_ARREADY) begin
					state_read <= Rdata;
					axi_araddr <= S_AXI_ARADDR;
					axi_rvalid <= 1'b1;
					axi_arready <= 1'b0;
				end else state_read <= state_read;
			end
			Rdata: begin
				if (S_AXI_RVALID && S_AXI_RREADY) begin
					axi_rvalid <= 1'b0;
					axi_arready <= 1'b1;
					state_read <= Raddr;
				end else state_read <= state_read;
			end
			endcase
		end
	end

	/*
	 * Read logic, again make sure you have the right OPT_MEM_ADDR_BITS value,
	 * and make sure the case values have the right address which is contained
	 * in the OPT_MEM_ADDR_BITS viewport [X : 2], this is straightforward
	 */
	assign S_AXI_RDATA = (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 14'b00000000000000) ? {31'b0, msip[0]} :
		  (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 14'b01000000000000) ? mtimecmp_l :
		  (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 14'b01000000000001) ? mtimecmp_h :
		  (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 14'b10111111111110) ? mtime_l :
		  (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 14'b10111111111111) ? mtime_h : 0;

	/* Device logic */

	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
		        mtime <= 64'b0;
		end else begin
			mtime <= mtime + 1;
		end
	end

	assign mtime_l = mtime[31:0];
	assign mtime_h = mtime[63:32];

	assign sftwr_irq = msip[0];
	assign timer_irq = (mtime >= {mtimecmp_h, mtimecmp_l});

endmodule
