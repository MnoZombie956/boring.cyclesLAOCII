# boring.cyclesLAOCII
### 3-cycles, 9bits instructions, 16bits data microprocessor with data inputs(DINs) for a course assignment and fpga testing.
## ISA and flag, IIIXXXYYY 9 bits
	000 - mv  regx, regy       rb[XXX] ← [rb[YYY]]  
		cc0:
			bus_sel <= 0;
			rb_read_sel <= 1;

			rb_write <= 1;
			ctrlu_instDone <= 1; 
	001 - mvi regx, #Immediate rb[XXX] ← Immediate 
		cc0:    
			bus_sel <= 1;
			
			rb_write <= 1;
			ctrlu_instDone <= 1;
	010 - add regx, regy       rb[XXX] ← [rb[XXX]]+[rb[YYY]]                     
	011 - sub regx, regy       rb[XXX] ← [rb[XXX]] − [rb[YYY]]
	100 - or  regx, regy       rb[XXX] ← [rb[XXX]] | [rb[YYY]]
	101 - slt regx, regy       If (rb[XXX] < rb[YYY]) [rb[XXX]] = 1 else [rb[XXX]] = 0
	110 - sll regx, regy       rb[XXX] = [rb[XXX]] << [rb[YYY]]
	111 - slr regx, regy       rb[XXX] = [rb[XXX]] >>[rb[YYY]] 
		cc0:
			bus_sel <= 0;
			rb_read_sel <= 0;
			
			a_reg_write <= 1;
			ctrlu_instDone <= 0; 
		cc1:
			bus_sel <= 0;
			rb_read_sel <= 1;

			alu_opcode <= 010(add) ou 011(sub) ou 110(or) ou 101(slt);
			g_reg_write <= 1;
		cc2:
			bus_sel <= 10;

			rb_write <= 1;
			ctrlu_instDone <= 1; 
## Outputs
![diagram](https://github.com/MnoZombie956/boring.cyclesLAOCII/blob/main/sim_waves.bmp?raw=true)
see also ```transcript_console.txt```
## Diagram
![diagram](https://github.com/MnoZombie956/boring.cyclesLAOCII/blob/main/diagram.png?raw=true)
