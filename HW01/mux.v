`timescale 1ns / 1ps

module mux#(
	localparam LEN = 32
)(
    input  [LEN-1:0]  inp0,
    input  [LEN-1:0]  inp1,
    input             sel,
    output [LEN-1:0]  out
);
	assign out = (sel) ? inp1 : inp0; 
//	reg [LEN-1:0]  result;
//	assign out = result;
//	always @* begin
//		if(sel)
//			result = inpB;
//		else
//			result = inpA;
//	end
endmodule
