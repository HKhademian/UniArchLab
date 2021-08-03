`timescale 1ns / 1ps

module mux_test;
	reg [31:0] inp0;
	reg [31:0] inp1;
	reg sel;
	wire [31:0] out;

	mux uut (
		.inp0(inp0), 
		.inp1(inp1), 
		.sel(sel), 
		.out(out)
	);

	initial begin
		inp0 = 0;
		inp1 = 0;
		sel = 0;
		#100;
        
		inp0 = 74;
		inp1 = 79;
		sel = 0;
		# 10;
		
		inp0 = 75;
		# 10;
		
		inp1 = 76;
		# 10;
		
		sel = 1;
		# 10;
		
		inp0 = 74;
		# 10;
		
		inp1 = 79;
		# 10;

	end
      
endmodule

