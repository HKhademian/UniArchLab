`timescale 1ns / 1ps

module reg_EXMEM_test;

	reg				clk;
	reg				in_hit;
	reg		[31:0]	in_branchTarget;
	reg				in_zeroFlag;
	reg		[31:0]	in_ALUResult;
	reg		[31:0]	in_readData2;
	reg		[4:0]	in_writeReg;
	reg				in_MemRead;
	reg				in_MemWrite;
	reg				in_Branch;
	reg				in_RegWrite;
	reg				in_MemToReg;
	
	wire			out_hit;
	wire	[31:0]	out_branchTarget;
	wire			out_zeroFlag;
	wire	[31:0]	out_ALUResult;
	wire	[31:0]	out_readData2;
	wire	[4:0]	out_writeReg;
	wire			out_MemRead;
	wire			out_MemWrite;
	wire			out_Branch;
	wire			out_RegWrite;
	wire			out_MemToReg;

	reg_EXMEM uut (
		clk,
		in_hit,  in_branchTarget,  in_zeroFlag,  in_ALUResult,  in_readData2,  in_writeReg,  in_MemRead,  in_MemWrite,  in_Branch,  in_RegWrite,  in_MemToReg,
		out_hit, out_branchTarget, out_zeroFlag, out_ALUResult, out_readData2, out_writeReg, out_MemRead, out_MemWrite, out_Branch, out_RegWrite, out_MemToReg
	);
	
	// clock generator
	initial forever #9 clk = ~clk;

	initial begin  
		clk = 0;
		in_hit = 0;
		in_branchTarget = 0;
		in_zeroFlag = 0;
		in_ALUResult = 0;
		in_readData2 = 0;
		in_writeReg = 0;
		in_MemRead = 0;
		in_MemWrite = 0;
		in_Branch = 0;
		in_RegWrite = 0;
		in_MemToReg = 0;
		#22;
      
		in_hit = 1;
		in_branchTarget = 1;
		in_zeroFlag = 1;
		in_ALUResult = 1;
		in_readData2 = 1;
		in_writeReg = 1;
		in_MemRead = 1;
		in_MemWrite = 1;
		in_Branch = 1;
		in_RegWrite = 1;
		in_MemToReg = 1;
		#36;
      
		in_hit = 1;
		in_branchTarget = 0;
		in_zeroFlag = 0;
		in_ALUResult = 0;
		in_readData2 = 0;
		in_writeReg = 0;
		in_MemRead = 0;
		in_MemWrite = 0;
		in_Branch = 0;
		in_RegWrite = 0;
		in_MemToReg = 0;
		#31;
      
		in_hit = 1;
		in_branchTarget = 1;
		in_zeroFlag = 1;
		in_ALUResult = 1;
		in_readData2 = 1;
		in_writeReg = 1;
		in_MemRead = 1;
		in_MemWrite = 1;
		in_Branch = 1;
		in_RegWrite = 1;
		in_MemToReg = 1;
		#36;
      
		in_hit = 0;
		in_branchTarget = 0;
		in_zeroFlag = 0;
		in_ALUResult = 0;
		in_readData2 = 0;
		in_writeReg = 0;
		in_MemRead = 0;
		in_MemWrite = 0;
		in_Branch = 0;
		in_RegWrite = 0;
		in_MemToReg = 0;
		#31;
		
		$finish;
		
	end
      
endmodule

