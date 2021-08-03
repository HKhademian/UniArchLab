`timescale 1ns / 1ps
module pipe_fetch (
	input						clk,
	input						PC_Write,
	input						PC_Src,
	input			[31:0]	BranchTarget,
	output		[31:0]	PC4,
	output		[31:0]	instruction,
	output					hit
);

wire [127:0] cache_data;
wire [31:0] next_pc;
wire [31:0] cur_pc;

// pc+4 module
assign PC4 = cur_pc + 4;

// mux for next_pc module
mux PC_MUX (
	.inp0(PC4),
	.inp1(BranchTarget),
	.sel (PC_Src),
	.out (next_pc)
);

// pc register module
reg_PC PC (
	.clk(clk),
	.en(PC_Write && hit),
	.in_addr(next_pc),
	.out_addr(cur_pc)
);

// cache module
mem_cache CACHE (
	.clk(clk),
	.address(cur_pc),
	.data_line(cache_data),
	.instruction(instruction),
	.hit(hit)
);

// instruction memory module
mem_inst INST (
	.clk(clk),
	.addr(cur_pc),
	.out(cache_data)
);


endmodule
