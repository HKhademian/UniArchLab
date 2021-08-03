`timescale 1ns / 1ps

module pipe_execute (
	input				clk,
	input  [31:0]	ALUReadData1,
	input  [31:0]	ALUReadData2,
	input  [31:0]	Immediate,
	// input  [5:0]	funct,
	// input  [4:0]	Shamt,
	input  [1:0]	ForwardA,
	input  [1:0]	ForwardB,
	
	input  [31:0]	forward_mem_data,
	input  [31:0]	forward_wb_data,

	input  [2:0]	ALUOp,
	input  			ALUSrc,
	output [31:0]	ALUResult,
	output  			ALUzero
	
);

	wire [5:0] funct = Immediate[5:0];
	wire [4:0] Shamt = Immediate[10:6];


	wire [3:0]		ALUCnt;
	
	// ALU Data1 MUX
	wire [31:0]		data1 = ForwardA==2'b10 ? (forward_mem_data):
								  ForwardA==2'b01 ? (forward_wb_data):
								  ALUReadData1;
	
	// ALU Data2 MUX
	wire [31:0]		data2 = ForwardA==2'b10 ? (forward_mem_data):
								  ForwardA==2'b01 ? (forward_wb_data):
								  (ALUSrc ? Immediate : ALUReadData2);

	alu_control_unit ALU_CU (
		.ALUOp(ALUOp),
		.funct(funct),
		.ALUCnt(ALUCnt)
	);

	alu ALU (
		.control(ALUCnt),
		.input1(data1),
		.input2(data2),
		.Shamt(Shamt),
		.Out(ALUResult),
		.Zero(ALUzero)
	);


endmodule
