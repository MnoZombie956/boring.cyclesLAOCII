module ProgramMemory(
	input [7:0] pm_address,
	output [8:0] pm_data_out
);	
	reg [8:0] rom_mem [0:255]; // matriz de 256 itens indexaveis, profundidade de 8 bits
	// integer i; // debugging

	initial begin
		$readmemb("C:/Users/ofzbo/Documents/projects/QuartusII_Altera/_aocII_Pratica2/ProgramInstructions.txt", rom_mem); // memory file

		/*$display("ProgramInstructions: ");
		for(i=0; i<256; i=i+1) begin
			$display("%b",rom_mem[i]);
		end*/		
	end
	assign pm_data_out = rom_mem[pm_address];
endmodule