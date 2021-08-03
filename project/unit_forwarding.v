`timescale 1ns / 1ps


module unit_forwarding (
	input  [4:0] EXMEM_RegisterRd,
	input  [4:0] MEMWB_RegisterRd,
	input        EXMEM_RegWrite,
	input        MEMWB_RegWrite,
	input  [4:0] IDEX_RegisterRs,
	input  [4:0] IDEX_RegisterRt,
	output [1:0] ForwardA,
	output [1:0] ForwardB
);

/*
1. EX hazard:
if (EX/MEM.RegWrite
and (EX/MEM.RegisterRd ≠ 0)
and (EX/MEM.RegisterRd = ID/EX.RegisterRs)) ForwardA = 10

if (EX/MEM.RegWrite
and (EX/MEM.RegisterRd ≠ 0)
and (EX/MEM.RegisterRd = ID/EX.RegisterRt)) ForwardB = 10



2. MEM hazard:
if (MEM/WB.RegWrite
and (MEM/WB.RegisterRd ≠ 0)
and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 0))
and (EX/MEM.RegisterRd ≠ ID/EX.RegisterRs)
and (MEM/WB.RegisterRd = ID/EX.RegisterRs)) ForwardA = 01

if (MEM/WB.RegWrite
and (MEM/WB.RegisterRd ≠ 0)
and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 0))
and (EX/MEM.RegisterRd ≠ ID/EX.RegisterRt)
and (MEM/WB.RegisterRd = ID/EX.RegisterRt)) ForwardB = 01
*/

assign ForwardA = (
	(EXMEM_RegWrite==1)
	&& (EXMEM_RegisterRd!=0)
	&& (EXMEM_RegisterRd==IDEX_RegisterRs)
) ?	2'b10 : (
	(MEMWB_RegWrite==1)
	&& (MEMWB_RegisterRd!=0)
	&& !((EXMEM_RegWrite==1) && (EXMEM_RegisterRd!=0))
	&& (EXMEM_RegisterRd!=IDEX_RegisterRs)
	&& (MEMWB_RegisterRd==IDEX_RegisterRs)
) ?	2'b01 :
2'b00;

assign ForwardB = (
	(EXMEM_RegWrite==1)
	&& (EXMEM_RegisterRd!=0)
	&& (EXMEM_RegisterRd==IDEX_RegisterRt)
) ?	2'b10 : (
	(MEMWB_RegWrite==1)
	&& (MEMWB_RegisterRd!=0)
	&& !((EXMEM_RegWrite==1) && (EXMEM_RegisterRd!=0))
	&& (EXMEM_RegisterRd!=IDEX_RegisterRt)
	&& (MEMWB_RegisterRd==IDEX_RegisterRt)
) ?	2'b01 :
2'b00;

endmodule
