`timescale 1ns / 1ps

module reg_PC_test;
	reg [31:0] in_addr;
	reg clk;
	reg en;
	wire [31:0] out_addr;

	reg_PC uut ( 
		.clk(clk),
		.en(en),
		.in_addr(in_addr), 
		.out_addr(out_addr)
	);

	initial forever #13 clk = ~clk;
	initial forever #17 in_addr = in_addr+10;
	initial forever #21 en = ~en;
	
	initial begin
		in_addr = 0;
		clk = 0;
		en = 0;

		#1000;
	end
      
endmodule

