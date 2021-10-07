module ArithmeticLogicalUnit(
	input [2:0] alu_op_code,
	input [15:0] a, b,
	output reg [15:0] s,
	output wrap_around
);
/*
	010 - add regx, regy       rb[XXX] ← [rb[XXX]]+[rb[YYY]]                     
	011 - sub regx, regy       rb[XXX] ← [rb[XXX]] − [rb[YYY]]
	100 - or  regx, regy       rb[XXX] ← [rb[XXX]] | [rb[YYY]]
	101 - slt regx, regy       If (rb[XXX] < rb[YYY]) [rb[XXX]] = 1 else [rb[XXX]] = 0
	110 - sll regx, regy       rb[XXX] = [rb[XXX]] << [rb[YYY]]
	111 - slr regx, regy       rb[XXX] = [rb[XXX]] >>[rb[YYY]] 
*/
	// 010 011 100 101 110 111
	reg extended_s;

	initial begin
		extended_s <= 0;
		s <= 16'b0;
	end

	always @(alu_op_code or a or b) begin
		case(alu_op_code)
			3'b010: begin
				{extended_s,s} <= a + b;
			end
			3'b011: begin
				{extended_s,s} <= b - a;				
			end
			3'b100: begin
				{extended_s,s} <= a | b;
			end
			3'b101: begin
				{extended_s,s} <= a > b ? 16'b1:16'b0;
			end
			3'b110: begin
				{extended_s,s} <= b << a;
			end
			3'b111: begin
				{extended_s,s} <= b >> a;				
			end
			default: begin
				extended_s <= 0;
				s <= 16'b0;
			end
		endcase
	end

	assign wrap_around = (a[15] & b[15] & ~s[15]) | ~a[15] & ~b[15] & s[15];

endmodule