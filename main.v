module Multiplexer3x2(
	input [2:0] in0,in1,
	input sel, 
	output reg [2:0] out
);	
	always@(*) begin
		case(sel)
			3'b0: out = in0;
			3'b1: out = in1;
		endcase
	end
endmodule
module Multiplexer16x4(
	input [15:0] in0,in1,in2,in3,
    input [1:0]sel, 
	output reg [15:0]out
);	
	always@(*) begin
		case(sel)
			3'b00: out = in0;
			3'b01: out = in1;
			3'b10: out = in2;
			3'b11: out = in3;
		endcase
	end
endmodule

module _aocII_Pratica2(//main
	input clk, rst,
	input [15:0] direct_input//DIN
);
	//Program counter wires
	wire [7:0] pc_out;

	//Program memory wires
	wire [7:0] pm_address;
	wire [8:0] pm_data_out;

	//Control Unit wires
	wire [8:0] ctrlu_inst;
	wire [1:0] ctrlu_step;
	wire ctrlu_instDone;
	wire [2:0] ctrlu_regx, ctrlu_regy;
	wire [2:0] ctrlu_alu_opcode;
	wire [1:0] ctrlu_bus_sel;
	wire ctrlu_a_reg_write, ctrlu_g_reg_write;
	wire ctrlu_rb_write, ctrlu_rb_read_in_sel;

	// Register A
	wire reg_a_write;
	wire [15:0] reg_a_data_in;
	wire [15:0] reg_a_data_out;

	// Register G
	wire reg_g_write;
	wire [15:0] reg_g_data_in;
	wire [15:0] reg_g_data_out;

	//Registers Bank
	wire rb_write;
	wire [2:0] rb_read_sel;
	wire [15:0] rb_data_in, rb_data_out;

	//ALU
	wire [15:0] alu_data_in_a, alu_data_in_b, alu_data_out;
	wire alu_wrap_around;

	// Bus
	wire [15:0] bus;

	// Fool
	wire [15:0] fool16bits;
	reg [15:0] TESTING_direct_input;
	integer cc;
	integer ic;

	//Internal Stimully
	reg [1:0] step;

	initial begin
		#0
		cc <= 0;
		ic <= 0;
		step <= 2'b0;
		TESTING_direct_input <= 16'b10;
		#10
		TESTING_direct_input <= 16'b11;
		#40
		TESTING_direct_input <= 16'b110;
		#210
		TESTING_direct_input <= 0;
	end

	ProgramCounter _PC_(.clk(clk),.tick(ctrlu_instDone),.rst(rst),.pc_out(pc_out));

	assign pm_address = pc_out;
	ProgramMemory _PM_(.pm_address(pm_address), .pm_data_out(pm_data_out));

	assign ctrlu_inst = pm_data_out;
	assign ctrlu_step = step;
	CtrlUnit _CTRLU_(
		.ctrlu_inst(ctrlu_inst),.ctrlu_step(ctrlu_step),.ctrlu_instDone(ctrlu_instDone),
		.rb_write(ctrlu_rb_write), .rb_read_in_sel(ctrlu_rb_read_in_sel), 
		.a_reg_write(ctrlu_a_reg_write),.g_reg_write(ctrlu_g_reg_write),
		.bus_sel(ctrlu_bus_sel),
		.regx(ctrlu_regx), .regy(ctrlu_regy),
		.alu_opcode(ctrlu_alu_opcode)
	);

	assign reg_a_data_in = bus;
	assign reg_a_write = ctrlu_a_reg_write;
	RegisterA _A_(
		.clk(clk),.rst(rst),
		.reg_a_data_in(reg_a_data_in),
		.write(reg_a_write),
		.reg_a_data_out(reg_a_data_out)
	);

	assign reg_g_data_in = alu_data_out;
	assign reg_g_write = ctrlu_g_reg_write;
	RegisterG _G_(
		.clk(clk),.rst(rst),
		.reg_g_data_in(reg_g_data_in),
		.write(reg_g_write),
		.reg_g_data_out(reg_g_data_out)
	);

	//select 
	Multiplexer3x2 _MUX3X2_1(
		.sel(ctrlu_rb_read_in_sel),
		.in0(ctrlu_regx),
		.in1(ctrlu_regy),
		.out(rb_read_sel)
	);

	assign rb_data_in = bus;
	assign rb_write = ctrlu_rb_write;
	RegistersBank _RB_(
		.clk(clk), .rst(rst), .write(rb_write),
		.rb_data_in(rb_data_in), 
		.read_sel(rb_read_sel), 
		.write_sel(ctrlu_regx),
		.rb_data_out(rb_data_out)
	);

	Multiplexer16x4 _MUX16X4_1(
		.sel(ctrlu_bus_sel),
		.in0(rb_data_out),
		.in1(direct_input),
		.in2(reg_g_data_out),
		.in3(fool16bits),
		.out(bus)
	);

	assign alu_data_in_a = bus;
	assign alu_data_in_b = reg_a_data_out;
	ArithmeticLogicalUnit _ALU_(
		.alu_op_code(ctrlu_inst[8:6]),
		.a(alu_data_in_a), .b(alu_data_in_b),
		.s(alu_data_out),
		.wrap_around(alu_wrap_around)
	);

	always @(posedge clk or posedge rst) begin
		$display("cc: %d ic: %d inst: %b step: %b DIN: %b\nrb_out: %b reg_a: %b reg_g: %b\nalu_out: %b (wa: %b)\n rb_write: %b bus: %b (sel: %b)\n\n",
			cc,ic,ctrlu_inst,ctrlu_step,TESTING_direct_input,rb_data_out,reg_a_data_out,reg_g_data_out,alu_data_out,alu_wrap_around,rb_write,bus,ctrlu_bus_sel
		);
		if (rst || ctrlu_instDone) begin
			step <= 2'b0;		
			ic = ic + 1;
		end
		else begin
			step <= step + 1'b1;
		end
		cc = cc + 1;
	end

	assign direct_input = TESTING_direct_input;

endmodule