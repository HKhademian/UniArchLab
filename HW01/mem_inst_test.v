`timescale 1ns / 1ps

module mem_inst_test;
	reg clk=0;
	reg [31:0] addr;
	wire [127:0] out;
	wire tick;
	
	mem_inst uut (
		.clk(clk), 
		.tick(tick),
		.addr(addr), 
		.out(out)
	);

	// out-of-sync clock
	initial forever #7 clk = ~clk; 
	
	initial begin
		addr = 100;
		#100;
		
		addr = 10;
		#10;
		
		addr = 20;
		#20;
		
		addr = 30;
		#30;
		
		addr = 40;
		#40;
		
		addr = 50;
		#50;
		
		addr = 60;
		#50;
		addr = 61;
		#50;
		addr = 62;
		#50;
		addr = 63;
		#50;
		addr = 64;
		#50;
		addr = 65;
		#50;
		addr = 66;
		#50;
		
		addr = 70;
		#70;
		
		addr = 80;
		#80;
		
		addr = 90;
		#90;
		
		addr = 100;
		#100;
	
		addr = 60;
		#60;
		
		addr = 70;
		#70;
		
		addr = 50;
		#50;
		
		addr = 60;
		#60;


	end
      
endmodule

