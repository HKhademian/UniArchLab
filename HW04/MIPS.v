`timescale 1ns / 1ps
module MIPS;

wire clk = 0;

wire hazard_stall;


//
// PIPE FETCH
//
wire			fetch_PC_Src;
wire [31:0] fetch_BranchTarget;
wire [31:0] fetch_nextPC;
wire [31:0] fetch_instruction;
wire			fetch_hit;
pipe_fetch PIPE_IF (
	.clk(clk),
	.PC_Write(hazard_stall==0),
	.PC_Src(fetch_PC_Src),
	.BranchTarget(fetch_BranchTarget),
	.PC4(fetch_nextPC),
	.instruction(fetch_instruction),
	.hit(fetch_hit)
);



//
// REG IFID
//
wire			decode_hit;
wire [31:0]	decode_nexPC;
wire [31:0]	decode_instruction;
reg_IFID REG_IFID (
	.clk(clk),
	
	.IFIDWrite(hazard_stall==0),
	.in_hit(fetch_hit),
	.in_next_pc(fetch_nextPC),
	.in_instruction(fetch_instruction),
	
	.out_hit(decode_hit),
	.out_next_pc(decode_nexPC),
	.out_instruction(decode_instruction)
);


//
// PIPE DECODE
//
wire			decode_write;
wire [4:0]	decode_writeReg;
wire [31:0]	decode_writeData;
wire [5:0]	decode_opcode;
wire [31:0]	decode_readData1;
wire [31:0]	decode_readData2;
wire [4:0]	decode_rt;
wire [4:0]	decode_rd;
wire [4:0]	decode_rs;
wire [5:0]	decode_funct;
wire [31:0]	decode_immediate;
pipe_decode PIPE_ID (
	.clk(clk),
	.instruction(decode_instruction),
	.write(decode_write),
	.write_reg(decode_writeReg),
	.write_data(decode_writeData),
	.opcode(decode_opcode),
	.read_data_1(decode_readData1),
	.read_data_2(decode_readData2),
	// .funct(decode_funct),
	.rt(decode_rt),
	.rd(decode_rd),
	.rs(decode_rs),
	.immediate(decode_immediate)
);


//
// Hazard Detection Unit
//
wire        hazard_idex_memread;
wire [4:0]  hazard_idex_regrt;
unit_hazard_detection HAZARD (
	.IDEX_MemRead(hazard_idex_memread),
	.IDEX_RegisterRt(hazard_idex_regrt),
	.IFID_RegisterRs(decode_rs),
	.IFID_RegisterRt(decode_rt),
	.stall(hazard_stall)
);


// CU
wire cu_RegDst;
wire cu_ALUSrc;
wire cu_MemtoReg;
wire cu_RegWrite;
wire cu_MemRead;
wire cu_MemWrite;
wire cu_Branch;
wire [2:0] cu_ALUOp;
control_unit CU (
	.opcode(decode_opcode),
	.RegDst(cu_RegDst),
	.ALUSrc(cu_ALUSrc),
	.MemtoReg(cu_MemtoReg),
	.RegWrite(cu_RegWrite),
	.MemRead(cu_MemRead),
	.MemWrite(cu_MemWrite),
	.Branch(cu_Branch),
	.ALUOp(cu_ALUOp)
);


//
// REG IDEX
//
wire ex_hit;
wire [31:0] ex_readData1;
wire [31:0] ex_readData2;
wire [31:0] ex_signExImmediate;
wire ex_RegDst;
wire ex_ALUSrc;
wire ex_MemRead;
wire ex_MemWrite;
wire ex_Branch;
wire [2:0] ex_ALUOp;
wire [4:0] ex_rs;
wire [4:0] ex_rt;
wire [4:0] ex_rd;
wire [5:0] ex_funct;
wire [31:0] ex_nextPC;
reg_IDEX REG_IDEX (
	.clk(clk),
	.in_hit(decode_hit),
	.in_readData1(decode_readData1),
	.in_readData2(decode_readData2),
	.in_signExImmediate(decode_immediate),
	.in_RegDst(hazard_stall ?   1'd0 : cu_RegDst),
	.in_ALUSrc(hazard_stall ?   1'd0 : cu_ALUSrc),
	.in_MemtoReg(hazard_stall ? 1'd0 : cu_MemtoReg),
	.in_RegWrite(hazard_stall ? 1'd0 : cu_RegWrite),
	.in_MemRead(hazard_stall ?  1'd0 : cu_MemRead),
	.in_MemWrite(hazard_stall ? 1'd0 : cu_MemWrite),
	.in_Branch(hazard_stall ?   1'd0 : cu_Branch),
	.in_ALUOp(hazard_stall ?    3'd0 : cu_ALUOp),
	.in_rs(decode_rs),
	.in_rt(decode_rt),
	.in_rd(decode_rd),
	.in_funct(decode_funct),
	.in_nextPC(decode_nexPC),
	
	.out_hit(ex_hit),
	.out_readData1(ex_readData1),
	.out_readData2(ex_readData2),
	.out_signExImmediate(ex_signExImmediate),
	.out_RegDst(ex_RegDst),
	.out_ALUSrc(ex_ALUSrc),
	.out_MemtoReg(ex_MemtoReg),
	.out_RegWrite(ex_RegWrite),
	.out_MemRead(ex_MemRead),
	.out_MemWrite(ex_MemWrite),
	.out_Branch(ex_Branch),
	.out_ALUOp(ex_ALUOp),
	.out_rs(ex_rs),
	.out_rt(ex_rt),
	.out_rd(ex_rd),
	.out_funct(ex_funct),
	.out_nextPC(ex_nextPC)
);

assign hazard_idex_memread = ex_MemRead;
assign hazard_idex_regrt = ex_rt;


//
// Forwarding Unit
//
wire [4:0] forward_exmem_regrd;
wire       forward_exmem_regwrite;
wire [4:0] forward_memwb_regrd;
wire       forward_memwb_regwrite;
wire [1:0] forward_ForwardA;
wire [1:0] forward_ForwardB;

unit_forwarding FORWARD (
	.EXMEM_RegisterRd(forward_exmem_regrd),
	.MEMWB_RegisterRd(forward_memwb_regrd),
	.EXMEM_RegWrite(forward_exmem_regwrite),
	.MEMWB_RegWrite(forward_memwb_regwrite),
	.IDEX_RegisterRs(ex_rs),
	.IDEX_RegisterRt(ex_rt),
	.ForwardA(forward_ForwardA),
	.ForwardB(forward_ForwardB)
);

//
// PIPE EXECUTE
//
wire [31:0] ex_ALUResult;
wire [31:0] forward_mem_data;
wire [31:0] forward_wb_data;
wire ex_ALUzero;

pipe_execute PIPE_EX (
	.clk(clk),
	.ALUReadData1(ex_readData1),
	.ALUReadData2(ex_readData2),
	.Immediate(ex_signExImmediate),
	// .funct(ex_funct),
	// .Shamt(ex_Shamt),
	.ForwardA(forward_ForwardA),
	.ForwardB(forward_ForwardB),
	.forward_mem_data(forward_mem_data),
	.forward_wb_data(forward_wb_data),
	
	.ALUOp(ex_ALUOp),
	.ALUSrc(ex_ALUSrc),
	.ALUResult(ex_ALUResult),
	.ALUzero(ex_ALUzero)
);

wire [4:0]  ex_writeReg = ex_RegDst ? ex_rt : ex_rd;
wire [31:0] ex_branchTarget = ex_nextPC + (ex_signExImmediate<<2);


//
// REG EXMEM
//
wire mem_hit;
wire mem_branch;
// wire mem_branchTarget; // fetch_branchTarget
wire mem_zeroFlag;
wire [31:0] mem_ALUResult;
wire [31:0] mem_readData2;
wire [4:0] mem_writeReg;
wire mem_MemRead;
wire mem_MemWrite;
wire mem_Branch;
wire mem_RegWrite;
wire mem_MemToReg;
reg_EXMEM REG_EXMEM (
	.clk(clk),

	.in_hit(ex_hit),
	.in_branchTarget(ex_branchTarget),
	.in_zeroFlag(ex_ALUzero),
	.in_ALUResult(ex_ALUResult),
	.in_readData2(ex_readData2),
	.in_writeReg(ex_writeReg),
	.in_MemRead(ex_MemRead),
	.in_MemWrite(ex_MemWrite),
	.in_Branch(ex_Branch),
	.in_RegWrite(ex_RegWrite),
	.in_MemToReg(ex_MemtoReg),
	
	.out_hit(mem_hit),
	.out_branchTarget(fetch_BranchTarget),
	.out_zeroFlag(mem_zeroFlag),
	.out_ALUResult(mem_ALUResult),
	.out_readData2(mem_readData2),
	.out_writeReg(mem_writeReg),
	.out_MemRead(mem_MemRead),
	.out_MemWrite(mem_MemWrite),
	.out_Branch(mem_Branch),
	.out_RegWrite(mem_RegWrite),
	.out_MemToReg(mem_MemToReg)
);

assign forward_exmem_regrd = mem_writeReg;
assign forward_exmem_regwrite = mem_RegWrite;
assign forward_mem_data = mem_ALUResult;

//
// PIPE MEM
//
wire [31:0] mem_readData;
mem_data PIPE_MEM (
	.clk(clk),
	.address(mem_ALUResult),
	.writeData(mem_readData2),
	.MemRead(mem_MemRead),
	.MemWrite(mem_MemWrite),
	.readData(mem_readData)
);

assign fetch_PC_Src = mem_Branch & mem_zeroFlag;


//
// REG MEMWB
//
wire wb_hit;
wire [31:0] wb_readData;
wire [31:0] wb_ALUResult;
wire wb_MemtoReg;
reg_MEMWB REG_MEMWB (
	.clk(clk),
	
    .in_hit(mem_hit),
    .in_readData(mem_readData),
    .in_ALUResult(mem_ALUResult),
    .in_writeReg(mem_writeReg),
    .in_RegWrite(mem_RegWrite),
    .in_MemtoReg(mem_MemToReg),

    .out_hit(wb_hit),
    .out_readData(wb_readData),
    .out_ALUResult(wb_ALUResult),
    .out_writeReg(decode_writeReg),
    .out_RegWrite(decode_write),
    .out_MemtoReg(wb_MemtoReg)
);

assign forward_memwb_regrd=decode_writeReg;
assign forward_memwb_regwrite=decode_write;
assign forward_wb_data = wb_ALUResult;

assign decode_writeData = wb_MemtoReg ? wb_readData : wb_ALUResult;

endmodule
