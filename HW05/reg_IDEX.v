`timescale 1ns / 1ps
module reg_IDEX (
	input						clk,
	
	input						in_hit,
	input			[31:0]	in_readData1,
	input			[31:0]	in_readData2,
	input			[31:0]	in_signExImmediate,
	input						in_RegDst,
	input						in_ALUSrc,
	input						in_MemtoReg,
	input						in_RegWrite,
	input						in_MemRead,
	input						in_MemWrite,
	input						in_Branch,
	input			[2:0]		in_ALUOp,
	input			[4:0]		in_rs,
	input			[4:0]		in_rt,
	input			[4:0]		in_rd,
	input			[5:0]		in_funct,
	input			[31:0]	in_nextPC,
	
	output reg				out_hit,
	output reg	[31:0]	out_readData1,
	output reg	[31:0]	out_readData2,
	output reg	[31:0]	out_signExImmediate,
	output reg				out_RegDst,
	output reg				out_ALUSrc,
	output reg				out_MemtoReg,
	output reg				out_RegWrite,
	output reg				out_MemRead,
	output reg				out_MemWrite,
	output reg				out_Branch,
	output reg	[2:0]		out_ALUOp,
	output reg	[4:0]		out_rs,
	output reg	[4:0]		out_rt,
	output reg	[4:0]		out_rd,
	output reg	[5:0]		out_funct,
	output reg	[31:0]	out_nextPC
);

	always @(negedge clk)
		if (in_hit)
			{ out_hit, out_readData1, out_readData2, out_signExImmediate, out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_Branch, out_ALUOp, out_rs, out_rt, out_rd, out_funct, out_nextPC } =
			{ in_hit,  in_readData1,  in_readData2,  in_signExImmediate,  in_RegDst,  in_ALUSrc,  in_MemtoReg,  in_RegWrite,  in_MemRead,  in_MemWrite,  in_Branch,  in_ALUOp,  in_rs,  in_rt,  in_rd,  in_funct,  in_nextPC  };
	
	initial
		{ out_hit, out_readData1, out_readData2, out_signExImmediate, out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_Branch, out_ALUOp, out_rs, out_rt, out_rd, out_funct, out_nextPC } = 0;

endmodule
