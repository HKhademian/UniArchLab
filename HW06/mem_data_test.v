`timescale 1ns / 1ps

module mem_data_test;

	reg clk=0;
	reg [31:0] address=0;
	reg [31:0] writeData=0;
	reg MemRead=0;
	reg MemWrite=0;

	wire [31:0] readData;

	mem_data uut (
		.clk(clk), 
		.address(address), 
		.writeData(writeData), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.readData(readData)
	);

	initial forever #9 clk = ~clk;

	initial begin
		#10;
        
		address = 5;
		#25;
		
		address = 7;
		MemRead = 1;
		#25;
		
		address = 9;
		MemRead = 0;
		MemWrite = 1;
		writeData = 74;
		#25;
		
		address = 9;
		MemRead = 1;
		MemWrite = 0;
		writeData = 35;
		#25;
		
		address = 7;
		MemRead = 0;
		MemWrite = 0;
		writeData = 0;
		#25;
		
		address = 9;
		MemRead = 0;
		MemWrite = 0;
		writeData = 0;
		#25;
		
		
	end
      
endmodule

