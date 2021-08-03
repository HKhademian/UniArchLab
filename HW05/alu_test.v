`timescale 1ns / 1ps


module alu_test;

	reg [3:0] control;
	reg [15:0] input1;
	reg [15:0] input2;
	reg [3:0] Shamt;

	wire [31:0] Out;
	wire Zero;

	alu uut (
		.control(control), 
		.input1(input1), 
		.input2(input2), 
		.Shamt(Shamt), 
		.Out(Out), 
		.Zero(Zero)
	);

	initial begin
		control = 0;
		input1 = 0;
		input2 = 0;
		Shamt = 0;
		#10;
        
		input1 = 74;
		input2 = 13;
		Shamt = 2;


		// inp1 + inp2
		control = 4'b0000;
		wait(Out==(input1+input2));
		#10;

		// inp1 - inp2
		control = 4'b001;
		wait(Out==(input1-input2));
		#10;

		// NOT inp1
		control = 4'b0010;
		wait(Out==(~input1));
		#10;

		// inp1 >> Shamt
		control = 4'b0011;
		wait(Out== (input1<<Shamt) );
		#10;

		// inp1 << Shamt
		control = 4'b0100;
		wait(Out== (input1>>Shamt) );
		#10;

		// inp1 & inp2
		control = 4'b0101;
		wait(Out== (input1&input2) );
		#10;

		// inp1 | inp2
		control = 4'b0110;
		wait(Out== (input1|input2) );
		#10;

		// inp1 <? inp2
		control = 4'b0111;
		wait(Out== (input1<input2?1:0) );
		#10;

		input2 = 74;
		input1 = 13;
		wait(Out== (input1<input2?1:0) );
		#10;
		
		
		input1 = 0;
		input2 = 0;
		control = 4'b1111;
		#10;
		$finish;

	end
      
endmodule

