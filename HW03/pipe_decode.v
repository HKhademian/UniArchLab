`timescale 1ns / 1ps

module pipe_decode (
	input 			clk,
	input  [31:0] 	instruction,
	input 			write,
	input  [4:0] 	write_reg,
	input  [31:0] 	write_data,
	output [5:0] 	opcode,
	output [31:0] 	read_data_1,
	output [31:0] 	read_data_2,
	output [4:0] 	rt,
	output [4:0] 	rd,
	output [4:0] 	rs,
	output [31:0] 	immediate
);

assign opcode = instruction[31:26];
assign immediate = { {16{instruction[15]}}, instruction[15:0] };

assign rs  = instruction[25:21];
assign rt  = instruction[20:16];
assign rd  = opcode==0?instruction[15:11]:instruction[20:16];
 

// mux for next_pc module
reg_FILE FILE (
	.clk			(clk),
	.reg_read_1	(rs),
	.reg_read_2	(rt),
	.write		(write),
	.reg_write	(write_reg),
	.write_data	(write_data),
	.reg_data_1	(read_data_1),
	.reg_data_2	(read_data_2)
);

endmodule
