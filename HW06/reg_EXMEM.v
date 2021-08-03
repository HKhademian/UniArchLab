`timescale 1ns / 1ps
module reg_EXMEM (
	input				clk,

	input				in_hit,
	input		[31:0]	in_branchTarget,
	input				in_zeroFlag,
	input		[31:0]	in_ALUResult,
	input		[31:0]	in_readData2,
	input		[4:0]	in_writeReg,
	input				in_MemRead,
	input				in_MemWrite,
	input				in_Branch,
	input				in_RegWrite,
	input				in_MemToReg,
	
	output reg			out_hit,
	output reg	[31:0]	out_branchTarget,
	output reg			out_zeroFlag,
	output reg	[31:0]	out_ALUResult,
	output reg	[31:0]	out_readData2,
	output reg	[4:0]	out_writeReg,
	output reg			out_MemRead,
	output reg			out_MemWrite,
	output reg			out_Branch,
	output reg			out_RegWrite,
	output reg			out_MemToReg
);

	always @(negedge clk) 
		if (in_hit)
			{ out_hit,	out_branchTarget,	out_zeroFlag,	out_ALUResult,	out_readData2,	out_writeReg,	out_MemRead,	out_MemWrite,	out_Branch,	out_RegWrite,	out_MemToReg } =
			{ in_hit,	in_branchTarget,	in_zeroFlag,	in_ALUResult,	in_readData2,	in_writeReg,	in_MemRead,		in_MemWrite,	in_Branch,	in_RegWrite,	in_MemToReg };
	
	initial
		{ out_hit,	out_branchTarget,	out_zeroFlag,	out_ALUResult,	out_readData2,	out_writeReg,	out_MemRead,	out_MemWrite,	out_Branch,	out_RegWrite,	out_MemToReg } = 0;
		
endmodule
