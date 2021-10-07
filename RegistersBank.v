module RegistersBank(
	input clk, rst, write,
	input [15:0] rb_data_in,
	input [2:0] read_sel, write_sel,
	output [15:0] rb_data_out
);
	integer i;

	reg [15:0] reg_bank [0:7];

	initial begin
		#0
		for(i=0; i<16; i=i+1)begin
			reg_bank[i] <= 16'b0;
		end
	end

	always @(posedge clk or posedge rst) begin
		$display("rb: %p",reg_bank);
		if (rst) begin
			for(i=0; i<16; i=i+1)begin
				reg_bank[i] <= 16'b0;
			end
		end
		else if (write) begin
			reg_bank[write_sel] <= rb_data_in;
		end
	end

	assign rb_data_out = reg_bank[read_sel];

endmodule