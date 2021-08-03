`timescale 1ns / 1ps

module reg_IFID_test;

	reg clk;
	reg [31:0] next_pc_in;
	reg [31:0] instruction_in;
	reg hit_in;

	wire [31:0] next_pc_out;
	wire [31:0] instruction_out;
	wire hit_out;

	reg_IFID uut (
		.clk(clk), 
		.next_pc_in(next_pc_in), 
		.instruction_in(instruction_in), 
		.hit_in(hit_in), 
		.next_pc_out(next_pc_out), 
		.instruction_out(instruction_out), 
		.hit_out(hit_out)
	);
	
	// clock generator
	initial forever #10 clk = ~clk;

	initial begin
		clk = 0;
		next_pc_in = 0;
		instruction_in = 0;
		hit_in = 0;
		#25;
      
		
		next_pc_in = 27;
		instruction_in = 39;
		hit_in  = 1;
		#30;
		
		next_pc_in = 69;
		instruction_in = 34;
		hit_in  = 0;
		#30;
		
		next_pc_in = 74;
		instruction_in = 27;
		hit_in  = 0;
		#30;
		
		next_pc_in = 79;
		instruction_in = 53;
		hit_in  = 1;
		#30;
		
		$finish;
		
	end
      
endmodule

