`timescale 1ns / 1ps

module reg_MEMWB_test;

	reg				clk=0;

	reg				in_hit;
	reg		[31:0]	in_readData;
	reg		[31:0]	in_ALUResult;
	reg		[4:0]	in_writeReg;
	reg				in_RegWrite;
	reg				in_MemtoReg;

	wire			out_hit;
	wire	[31:0]	out_readData;
	wire	[31:0]	out_ALUResult;
	wire	[4:0]	out_writeReg;
	wire			out_RegWrite;
	wire			out_MemtoReg;

	reg_MEMWB uut (
		clk,
		in_hit,  in_readData,  in_ALUResult,  in_writeReg,  in_RegWrite,  in_MemtoReg,
		out_hit,  out_readData,  out_ALUResult,  out_writeReg,  out_RegWrite,  out_MemtoReg
	);
	
	// clock generator
	initial forever #9 clk = ~clk;

	initial begin  
		in_hit = 0;
		in_readData = 0;
		in_ALUResult = 0;
		in_writeReg = 0;
		in_RegWrite = 0;
		in_MemtoReg = 0;
		#22;
      
		in_hit = 1;
		in_readData = 1;
		in_ALUResult = 1;
		in_writeReg = 1;
		in_RegWrite = 1;
		in_MemtoReg = 1;
		#36;
      
		in_hit = 1;
		in_readData = 0;
		in_ALUResult = 0;
		in_writeReg = 0;
		in_RegWrite = 0;
		in_MemtoReg = 0;
		#31;
      
		in_hit = 1;
		in_readData = 1;
		in_ALUResult = 1;
		in_writeReg = 1;
		in_RegWrite = 1;
		in_MemtoReg = 1;
		#36;
      
		in_hit = 0;
		in_readData = 0;
		in_ALUResult = 0;
		in_writeReg = 0;
		in_RegWrite = 0;
		in_MemtoReg = 0;
		#31;
		
		$finish;
		
	end
      
endmodule

