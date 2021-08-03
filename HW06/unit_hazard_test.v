`timescale 1ns / 1ps

module unit_hazard_test;

	// Inputs
	reg IDEX_MemRead;
	reg [4:0] IDEX_RegisterRt;
	reg [4:0] IFID_RegisterRs;
	reg [4:0] IFID_RegisterRt;

	// Outputs
	wire stall;

	// Instantiate the Unit Under Test (UUT)
	unit_hazard_detection uut (
		.IDEX_MemRead(IDEX_MemRead), 
		.IDEX_RegisterRt(IDEX_RegisterRt), 
		.IFID_RegisterRs(IFID_RegisterRs), 
		.IFID_RegisterRt(IFID_RegisterRt), 
		.stall(stall)
	);

	initial begin
		// Initialize Inputs
		IDEX_MemRead = 0;
		IDEX_RegisterRt = 0;
		IFID_RegisterRs = 0;
		IFID_RegisterRt = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		IDEX_MemRead = 0;
		IDEX_RegisterRt=5;
		IFID_RegisterRs=4;
		IFID_RegisterRt=5;
		#10;
      
		IDEX_MemRead = 1;
		IDEX_RegisterRt=5;
		IFID_RegisterRs=4;
		IFID_RegisterRt=5;
		#10;
      
		IDEX_MemRead = 1;
		IDEX_RegisterRt=5;
		IFID_RegisterRs=4;
		IFID_RegisterRt=4;
		#10;
      
		IDEX_MemRead = 0;
		IDEX_RegisterRt=5;
		IFID_RegisterRs=4;
		IFID_RegisterRt=4;
		#10;

		IDEX_MemRead = 0;
		IDEX_RegisterRt = 0;
		IFID_RegisterRs = 0;
		IFID_RegisterRt = 0;

	end
      
endmodule

