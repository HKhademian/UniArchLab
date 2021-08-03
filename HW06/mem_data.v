`timescale 1ns / 1ps

module mem_data  (
	input clk,
	input [31:0] address,
	input [31:0] writeData,
	input MemRead,
	input MemWrite,
	output reg	[31:0] readData
);
	// 1K word memory
	reg [31:0] memory [0:1023];
	
	// I use 4-byte aligned addresses
	// if it's wrong , just need to remove >>2
	
	always @(posedge clk) begin
		if (MemWrite)
			memory[address>>2] = writeData;
		
		readData = MemRead ? memory[address>>2] : 0;
	end


	integer i=0;
	initial 
		for (i=0; i<1024; i=i+1)
			memory[i]=i;

endmodule
