`timescale 1ns / 1ps
module reg_MEMWB (
	input				clk,

	input				in_hit,
	input		[31:0]	in_readData,
	input		[31:0]	in_ALUResult,
	input		[4:0]	in_writeReg,
	input				in_RegWrite,
	input				in_MemtoReg,

	output reg			out_hit,
	output reg	[31:0]	out_readData,
	output reg	[31:0]	out_ALUResult,
	output reg	[4:0]	out_writeReg,
	output reg			out_RegWrite,
	output reg			out_MemtoReg
);

	always @(negedge clk) 
		if (in_hit)
			{ out_hit,	out_readData,	out_ALUResult,	out_writeReg,	out_RegWrite,	out_MemtoReg } =
			{ in_hit,	in_readData,	in_ALUResult,	in_writeReg,	in_RegWrite,	in_MemtoReg };
	
	initial
		{ out_hit,	out_readData,	out_ALUResult,	out_writeReg,	out_RegWrite,	out_MemtoReg } = 0;
		
endmodule
