`timescale 1ns / 1ps

module pipe_decode_test;
	reg clk;
	reg [31:0] pc4i;
	reg [31:0] instruction;
	reg write;
	reg [4:0] write_reg;
	reg [31:0] write_data;

	wire [5:0] opcode;
	wire [31:0] immediate;
	wire [4:0] inst_rt;
	wire [4:0] inst_rd;
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;

	pipe_decode uut (
		.clk(clk), 
		.pc4(pc4i), 
		.instruction(instruction), 
		.write(write), 
		.write_reg(write_reg), 
		.write_data(write_data), 
		.opcode(opcode), 
		.immediate(immediate), 
		.inst_rt(inst_rt), 
		.inst_rd(inst_rd), 
		.read_data_1(read_data_1), 
		.read_data_2(read_data_2)
	);
	
	// clock pulse
	initial forever #5 clk=~clk;

	initial begin
		clk = 0;
		pc4i = 0;
		instruction = 0;
		write = 0;
		write_reg = 0;
		write_data = 0;
		#10;
		wait(clk==0);
		
		// test PC
		
		pc4i = 4;
		#11;
		wait(clk==0);
		
		pc4i = 8;
		#11;
		wait(clk==0);
		
		pc4i = 12;
		#11;
		wait(clk==0);
		
		// test instruction
		instruction = {4'b0000, 5'b01010, 5'b01101, 5'b11100, 5'b0, 5'b0 };
		#11;
		wait(clk==0);



	end
      
endmodule

