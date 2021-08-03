`timescale 1ns / 1ps

module control_unit(
	input [5:0] opcode,
	output RegDst,
	output ALUSrc,
	output MemtoReg,
	output RegWrite,
	output MemRead,
	output MemWrite,
	output Branch,
	output [2:0] ALUOp
);

	wire is_R_type  = opcode==6'b000000;
	wire is_lw      = opcode==6'b000100;
	wire is_sw      = opcode==6'b000101;
	wire is_addi    = opcode==6'b000111;
	wire is_beq     = opcode==6'b000110;
	wire is_slti    = opcode==6'b000001;
	
	assign RegDst   = is_R_type;
	assign ALUSrc   = is_lw || is_sw || is_addi || is_slti;
	assign MemtoReg = is_lw;
	assign RegWrite = is_R_type || is_lw || is_addi || is_slti;
	assign MemRead  = is_lw;
	assign MemWrite = is_sw;
	assign Branch   = is_beq;
	
	assign ALUOp =   
		is_R_type                  ? 3'b000 :
		is_lw || is_sw || is_addi  ? 3'b011 :
		is_beq                     ? 3'b001 :
		is_slti                    ? 3'b010 :
		                             3'b000 ; // error code

endmodule
