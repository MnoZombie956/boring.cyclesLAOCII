module RegisterA(
	input clk,rst,
	input [15:0] reg_a_data_in,
	input write,
	output [15:0] reg_a_data_out
);

	reg [15:0] reg_a;

	initial begin
		reg_a <= 16'b0;
	end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			reg_a <= 16'b0;
		end
		else if (write == 1) begin
			reg_a <= reg_a_data_in;
		end
	end

	assign reg_a_data_out = reg_a;

endmodule