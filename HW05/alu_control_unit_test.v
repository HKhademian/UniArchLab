`timescale 1ns / 1ps

module alu_control_unit_test;

	reg [2:0] ALUOp;
	reg [5:0] funct;

	wire [3:0] ALUCnt;

	alu_control_unit uut (
		.ALUOp(ALUOp), 
		.funct(funct), 
		.ALUCnt(ALUCnt)
	);

	initial begin
		ALUOp = 0;
		funct = 0;
		#20;
		

		// r-type ADD
		ALUOp = 3'b000;
		funct = 6'b000000;
		wait(ALUCnt == 4'b0000);
		#10;

		// r-type SUB
		ALUOp = 3'b000;
		funct = 6'b000001;
		wait(ALUCnt == 4'b0001);
		#10;

		// r-type AND
		ALUOp = 3'b000;
		funct = 6'b000010;
		wait(ALUCnt == 4'b0101);
		#10;

		// r-type OR
		ALUOp = 3'b000;
		funct = 6'b000011;
		wait(ALUCnt == 4'b0110);
		#10;

		// r-type SLT
		ALUOp = 3'b000;
		funct = 6'b000100;
		wait(ALUCnt == 4'b0111);
		#10;

		// r-type LSL
		ALUOp = 3'b000;
		funct = 6'b000101;
		wait(ALUCnt == 4'b0011);
		#10;

		// r-type LSR
		ALUOp = 3'b000;
		funct = 6'b000110;
		wait(ALUCnt == 4'b0100);
		#10;

		// r-type NOT
		ALUOp = 3'b000;
		funct = 6'b000111;
		wait(ALUCnt == 4'b0010);
		#10;

		// BEQ -> SUB
		ALUOp = 3'b001;
		funct = 6'b000000;
		wait(ALUCnt == 4'b0001);
		#10;

		// SLTI -> SLT
		ALUOp = 3'b010;
		funct = 6'b000000;
		wait(ALUCnt == 4'b0111);
		#10;

		// ADDI LW SW -> ADD
		ALUOp = 3'b011;
		funct = 6'b000000;
		wait(ALUCnt == 4'b0000);
		#10;

		ALUOp = 3'b000;
		funct = 6'b000000;
		wait(ALUCnt == 4'b0000);
		#1;
		$finish;
		
	end
      
endmodule

