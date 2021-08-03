`timescale 1ns / 1ps

module reg_IFID (
	input clk,
	input IFIDWrite,
	input in_hit,
	input [31:0] in_next_pc,
	input [31:0] in_instruction,
	output reg out_hit,
	output reg [31:0] out_next_pc,
	output reg [31:0] out_instruction
);

	always @(negedge clk)
		if (in_hit && IFIDWrite)
			{ out_hit, out_next_pc, out_instruction } = 
			{ in_hit, in_next_pc, in_instruction };

	initial
		{ out_hit, out_next_pc, out_instruction } = 0;
		
endmodule
