`timescale 1ns / 1ps

module reg_PC #(
	localparam N=32
)(
	input clk,
	input en,
	input [N-1:0] in_addr,
	output reg [N-1:0] out_addr
);
	always @(negedge clk)
		if(en)
			{ out_addr } = { in_addr };
		
	initial
		{ out_addr } = 0;
		
endmodule
