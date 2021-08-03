`timescale 1ns / 1ps


module control_unit_test;

	reg [5:0] opcode;

	wire RegDst;
	wire ALUSrc;
	wire MemtoReg;
	wire RegWrite;
	wire MemRead;
	wire MemWrite;
	wire Branch;
	wire [2:0] ALUOp;
	
	wire [6:0] state = {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch } ;

	control_unit uut (
		.opcode(opcode), 
		.RegDst(RegDst), 
		.ALUSrc(ALUSrc), 
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.Branch(Branch), 
		.ALUOp(ALUOp)
	);

	initial begin
		opcode = 6'b000000;
		#10;
        
		// LW
		opcode = 6'b000100;
		wait (state == 7'b0111100);
		wait (ALUOp == 3'b011);
		#10;
      
		// R-type
		opcode = 6'b000000;
		wait (state == 7'b1001000);
		wait (ALUOp == 3'b000);
		#10;
      
		// SW
		opcode = 6'b000101;
		wait (state == 7'b0100010);
		wait (ALUOp == 3'b011);
		#10;
      
		// BEQ
		opcode = 6'b000110;
		wait (state == 7'b0000001);
		wait (ALUOp == 3'b001);
		#10;
      
		// ADDI
		opcode = 6'b000111;
		wait (state == 7'b0101000);
		wait (ALUOp == 3'b011);
		#10;
      
		// SLTI
		opcode = 6'b000001;
		wait (state == 7'b0101000);
		wait (ALUOp == 3'b010);
		#10;

		opcode = 6'b000000;
		#1;
		$finish;
	end
      
endmodule

