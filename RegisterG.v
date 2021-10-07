module RegisterG(
	input clk,rst,
	input [15:0] reg_g_data_in,
	input write,
	output [15:0] reg_g_data_out
);

	reg [15:0] reg_g;

	initial begin
		reg_g <= 16'b0;
	end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			reg_g <= 16'b0;
		end
		else if (write == 1) begin
			reg_g <= reg_g_data_in;
		end
	end

	assign reg_g_data_out = reg_g;

endmodule