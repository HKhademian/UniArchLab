`timescale 1ns / 1ps

module mem_inst #(
	localparam N = 32
)(
	input							clk,
	input			[N-1:0]		addr,
	output reg	[4*N-1:0]	out
);
	// 1K word memory
	reg [N-1:0] memory [0:1023];
	
	reg [N-1:0] last_addr = 0;
	reg [N-1:0] new_addr = 0;
	integer counter = 0; 
	
	initial out = 0;
	
	always @(posedge clk) begin
		if (addr[31:4] != new_addr[31:4]) begin
			counter = 5;
			new_addr = addr;
		end
		else if(counter >= 0) counter = counter - 1;
		
		if(counter == 1) begin
			last_addr =  new_addr>>4; // drop 2bit offset and 2bit local(byte index in word)
			
			out[31:0] = memory[last_addr  + 0];
			out[63:32] = memory[last_addr + 1];
			out[96:63] = memory[last_addr + 2];
			out[127:96] = memory[last_addr+ 3];
			
//			out[31:0] = memory[last_addr][0];
//			out[63:32] = memory[last_addr][1];
//			out[96:63] = memory[last_addr][2];
//			out[127:96] = memory[last_addr][3];
			
			// test
//			out[31:0] = last_addr;   
//			out[63:32] = last_addr+1;
//			out[95:64] = last_addr+2;
//			out[127:96] = last_addr+3;
			
			// test
			// out = last_addr;
		end
	end


	integer i=0;
	initial 
		for (i=0;i<1024;i = i+1)
			memory[i]=i;

endmodule
