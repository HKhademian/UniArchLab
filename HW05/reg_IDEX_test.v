`timescale 1ns / 1ps

module reg_IDEX_test;

	reg clk;
	
	reg in_hit;
	reg [31:0] in_readData1;
	reg [31:0] in_readData2;
	reg [31:0] in_signExImmediate;
	reg in_RegDst;
	reg in_ALUSrc;
	reg in_MemtoReg;
	reg in_RegWrite;
	reg in_MemRead;
	reg in_MemWrite;
	reg in_Branch;
	reg [2:0] in_ALUOp;
	reg [4:0] in_rt;
	reg [4:0] in_rd;
	reg [5:0] in_funct;
	reg [31:0] in_nextPC;
	
	wire out_hit;
	wire [31:0] out_readData1;
	wire [31:0] out_readData2;
	wire [31:0] out_signExImmediate;
	wire out_RegDst;
	wire out_ALUSrc;
	wire out_MemtoReg;
	wire out_RegWrite;
	wire out_MemRead;
	wire out_MemWrite;
	wire out_Branch;
	wire [2:0] out_ALUOp;
	wire [4:0] out_rt;
	wire [4:0] out_rd;
	wire [5:0] out_funct;
	wire [31:0] out_nextPC;

	reg_IDEX uut (
		clk, 
		in_hit, in_readData1, in_readData2, in_signExImmediate, in_RegDst, in_ALUSrc, in_MemtoReg, in_RegWrite, in_MemRead, in_MemWrite, in_Branch, in_ALUOp, in_rt, in_rd, in_funct, in_nextPC,
		out_hit, out_readData1, out_readData2, out_signExImmediate, out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_Branch, out_ALUOp, out_rt, out_rd, out_funct, out_nextPC
	);
	
	// clock generator
	initial forever #9 clk = ~clk;

	initial begin
		clk = 0;
		{ in_hit, in_readData1, in_readData2, in_signExImmediate, in_RegDst, in_ALUSrc, in_MemtoReg, in_RegWrite, in_MemRead, in_MemWrite, in_Branch, in_ALUOp, in_rt, in_rd, in_funct, in_nextPC } = 0;
		#22;
      
		in_hit = 1;
		in_readData1 = 1;
		in_readData2 = 1;
		in_signExImmediate = 1;
		in_RegDst = 1;
		in_ALUSrc = 1;
		in_MemtoReg = 1;
		in_RegWrite = 1;
		in_MemRead = 1;
		in_MemWrite = 1;
		in_Branch = 1;
		in_ALUOp = 1;
		in_rt = 1;
		in_rd = 1;
		in_funct = 1;
		in_nextPC = 1;
		#36;
      
		in_hit = 1;
		{ in_hit, in_readData1, in_readData2, in_signExImmediate, in_RegDst, in_ALUSrc, in_MemtoReg, in_RegWrite, in_MemRead, in_MemWrite, in_Branch, in_ALUOp, in_rt, in_rd, in_funct, in_nextPC } = 0;
		#31;
      
		in_hit = 1;
		in_readData1 = 1;
		in_readData2 = 1;
		in_signExImmediate = 1;
		in_RegDst = 1;
		in_ALUSrc = 1;
		in_MemtoReg = 1;
		in_RegWrite = 1;
		in_MemRead = 1;
		in_MemWrite = 1;
		in_Branch = 1;
		in_ALUOp = 1;
		in_rt = 1;
		in_rd = 1;
		in_funct = 1;
		in_nextPC = 1;
		#36;
      
		in_hit = 0;
		{ in_hit, in_readData1, in_readData2, in_signExImmediate, in_RegDst, in_ALUSrc, in_MemtoReg, in_RegWrite, in_MemRead, in_MemWrite, in_Branch, in_ALUOp, in_rt, in_rd, in_funct, in_nextPC } = 0;
		#31;
      
		in_hit = 1;
		#31;
      
		in_hit = 0;
		#31;
		
		// $finish;
		
	end
      
endmodule

