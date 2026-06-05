`timescale 1 ns / 1 ps

module audio_pwm #(
	parameter integer AXI_DATA_WIDTH = 32,
	parameter integer AXI_ADDR_WIDTH = 16
) (
	output wire pwm,
	output wire sd,

	output wire fifo_refill_intr,

	input  wire [15:0] M_AXIS_tdata,
	output wire M_AXIS_tready,
	input  wire M_AXIS_tvalid,

	input  wire prog_empty,

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
	audio_pwm_impl # ( 
		.AXI_DATA_WIDTH(32),
		.AXI_ADDR_WIDTH(16)
	) audio_pwm_instance (
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
	
		.audio_pwm(pwm),
		.audio_sd(sd),

		.fifo_refill_intr(fifo_refill_intr),

		.M_AXIS_TDATA(M_AXIS_tdata),
		.M_AXIS_TREADY(M_AXIS_tready),
		.M_AXIS_TVALID(M_AXIS_tvalid),

		.prog_empty(prog_empty)
	);

endmodule

module audio_pwm_impl #(
	parameter integer AXI_DATA_WIDTH = 32,
	parameter integer AXI_ADDR_WIDTH = 16
) (
	output wire audio_pwm,
	output wire audio_sd,

	output wire fifo_refill_intr,

	input  wire [15:0] M_AXIS_TDATA,
	output wire M_AXIS_TREADY,
	input  wire M_AXIS_TVALID,

	input  wire prog_empty,

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
	localparam integer OPT_MEM_ADDR_BITS = 2;

	/* Device Control Registers */
	reg [AXI_DATA_WIDTH-1:0] audio_clk_div;
	reg [AXI_DATA_WIDTH-1:0] control;

	integer	byte_index;

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
			// Default value of 100MHz
			audio_clk_div <= 32'd2268;
			control <= 0;
		end else begin
			if (S_AXI_WVALID) begin
				case ( (S_AXI_AWVALID) ? S_AXI_AWADDR[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] : 
					axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
				3'b000: begin
					for ( byte_index = 0; byte_index <= (AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 ) begin
						if ( S_AXI_WSTRB[byte_index] == 1 ) begin
							audio_clk_div[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						end
					end
				end
				3'b001: begin
					for ( byte_index = 0; byte_index <= (AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 ) begin
						if ( S_AXI_WSTRB[byte_index] == 1 ) begin
							control[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
						end
					end
				end
				default : begin
					audio_clk_div <= audio_clk_div;
					control <= control;
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

	/* Device logic */

	wire intr_state = control[0];
	wire chip_state = control[1];

	assign audio_sd = chip_state;

	reg  [15:0] current_sample;

	reg         sample_request;
	reg  [31:0] sample_counter;

	assign M_AXIS_TREADY = sample_request;

	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			sample_request <= 0;
		end else begin
			sample_request <= (sample_counter == 32'd1) && intr_state && chip_state;
		end
	end

 	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			sample_counter <= 32'd2268;
		end else if (sample_request) begin
			sample_counter <= audio_clk_div[31:0];
		end else begin
			sample_counter <= sample_counter - 16'd1;
		end
	end

	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			current_sample <= 0;
		end else if (M_AXIS_TVALID && M_AXIS_TREADY) begin
			current_sample <= { ~M_AXIS_TDATA[15], M_AXIS_TDATA[14:0] };
		end
	end

	assign fifo_refill_intr = prog_empty && intr_state;

	reg [15:0] pwm_counter;
	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			pwm_counter <= 16'h0;
		end else begin
			pwm_counter <= pwm_counter + 16'd1;
		end
	end

	wire [15:0] pwm_reversed_counter;
	generate
		genvar k;
		for (k = 0; k < 16; k = k + 1) begin
			assign pwm_reversed_counter[k] = pwm_counter[15 - k];
		end
	endgenerate

	reg audio_pwm_r;
	always @(posedge S_AXI_ACLK) begin
		if (S_AXI_ARESETN == 1'b0) begin
			audio_pwm_r <= 1'b0;
		end else begin
			audio_pwm_r <= (current_sample >= pwm_reversed_counter);
		end
	end

	assign audio_pwm = audio_pwm_r;

	/* Handle AXI read operation */
	assign S_AXI_RDATA = (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 3'b000) ? audio_clk_div :
		(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 3'b001) ? { 30'b0, chip_state, intr_state } :
		(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 3'b010) ? { 31'b0, prog_empty } : 0;

endmodule
