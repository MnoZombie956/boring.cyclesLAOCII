module ProgramCounter(
	input clk,rst,tick,
	output [7:0] pc_out
);

	reg [7:0] counter;

	initial begin
		#0
		counter <= 8'b0;
	end

	always @(posedge clk or posedge rst) begin
		if (rst==1) begin
			counter<=8'b0;
		end
		else if (tick==1) begin
			counter <= counter + 1'b1;
		end
	end

	assign pc_out = counter;
	
endmodule