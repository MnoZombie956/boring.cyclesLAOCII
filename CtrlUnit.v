module CtrlUnit(
	input [8:0] ctrlu_inst,
	input [1:0] ctrlu_step,
	output reg ctrlu_instDone,
	// Control Signals
	// "A" and "G" register write flag
	output reg a_reg_write,
	output reg g_reg_write,
	// RegistersBank's flag and Mux's control
	output reg rb_write,
	output reg rb_read_in_sel,
	// Bus' Mux control
	output reg [1:0] bus_sel,
	// Alu operation
	output reg [2:0] alu_opcode,
	// Register's Field Values
	output [2:0] regx, regy
);

	//Instruction decomposition
	wire [3:0] op_code;
	assign op_code = ctrlu_inst[8:6];

	assign regx = ctrlu_inst[5:3];
	assign regy = ctrlu_inst[2:0]; 

	initial begin
		#0
		a_reg_write <= 0;
		g_reg_write <= 0;
		rb_write <= 0;
		rb_read_in_sel <= 0;
		ctrlu_instDone <= 0;
		bus_sel <= 0;
		alu_opcode <= 0;

	end

	always@(ctrlu_inst or ctrlu_step) begin
		case(op_code)
			3'b000: begin // mv
				case(ctrlu_step)//mv
					2'b00: begin
						bus_sel <= 0;
						rb_read_in_sel <= 1;

						rb_write <= 1;
						ctrlu_instDone <= 1; 

						a_reg_write <= 0;
						g_reg_write <= 0;

						alu_opcode <= 0;
					end
					default: begin
						$display("Unexpeted step in mv, not reseted");
					end
				endcase
			end
			3'b001: begin // mvi
				case(ctrlu_step)
					2'b00: begin
						bus_sel <= 1;
			
						rb_write <= 1;
						ctrlu_instDone <= 1;

						a_reg_write <= 0;
						g_reg_write <= 0;

						rb_read_in_sel <= 0;
						alu_opcode <= 0;
					end
					default: begin
						$display("Unexpeted step in mvi, not reseted");
					end
				endcase	
			end
			3'b010,3'b011,3'b100,3'b101,3'b110,3'b111: begin // add,sub,or,slt,sll,slr
				case(ctrlu_step)
					2'b00: begin
						bus_sel <= 0;
						rb_read_in_sel <= 0;
						
						ctrlu_instDone <= 0; 						
						
						a_reg_write <= 1;
						g_reg_write <= 0;

						rb_write <= 0;
						alu_opcode <= 0;
					end
					2'b01: begin
						bus_sel <= 0;
						rb_read_in_sel <= 1;

						alu_opcode <= op_code;

						a_reg_write <= 0;
						g_reg_write <= 1;	

						ctrlu_instDone <= 0;				
					end
					2'b10: begin
						bus_sel <= 10;

						rb_write <= 1;
						a_reg_write <= 0;
						g_reg_write <= 0;	

						ctrlu_instDone <= 1; 

						rb_read_in_sel <= 0;
						alu_opcode <= 0;
					end
					default: begin
						$display("Unexpeted step in aluops, not reseted");
					end						
				endcase
			end
		endcase
	end
endmodule