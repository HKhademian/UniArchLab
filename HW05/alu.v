`timescale 1ns / 1ps

module alu(
	input  [3:0]	control,
	input  [31:0]	input1,
	input  [31:0]	input2,
	input  [4:0] 	Shamt,
	output [31:0]	Out,
	output 			Zero
);

	wire [31:0] input1_32 = input1;//{{16{input1[15]}}, input1[15:0]};
	wire [31:0] input2_32 = input2;//{{16{input2[15]}}, input2[15:0]};

	assign Out =
		control == 4'b0000 ? input1_32 + input2_32 :
		control == 4'b0001 ? input1_32 - input2_32 :
		control == 4'b0010 ? ~input1_32 :
		control == 4'b0011 ? input1_32 << Shamt :
		control == 4'b0100 ? input1_32 >> Shamt :
		control == 4'b0101 ? input1_32 & input2_32 :
		control == 4'b0110 ? input1_32 | input2_32 :
		control == 4'b0111 ? (input1_32 < input2_32 ? 32'd1 : 32'd0) :
									32'dx; // error
			
	assign Zero = Out == 0;

endmodule
