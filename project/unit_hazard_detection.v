`timescale 1ns / 1ps
module unit_hazard_detection(
	input         IDEX_MemRead,
	input  [4:0]  IDEX_RegisterRt,
	input  [4:0]  IFID_RegisterRs,
	input  [4:0]  IFID_RegisterRt,
	output        stall
);

/* P372
if (ID/EX.MemRead and
((ID/EX.RegisterRt = IF/ID.RegisterRs) or
(ID/EX.RegisterRt = IF/ID.RegisterRt)))
stall the pipeline
*/

assign stall = (IDEX_MemRead==1) && (
	(IDEX_RegisterRt==IFID_RegisterRs)
	|| (IDEX_RegisterRt==IFID_RegisterRt)
);

endmodule
