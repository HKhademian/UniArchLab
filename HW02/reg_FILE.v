`timescale 1ns / 1ps
module reg_FILE (
	input 		      clk,
	input 		      write,
	input             [4:0]  reg_read_1 ,
	input             [4:0]  reg_read_2 ,
	input             [4:0]  reg_write  ,
	input             [31:0] write_data ,
	output  /*reg*/   [31:0] reg_data_1 ,
	output  /*reg*/   [31:0] reg_data_2
);

	reg [31:0] file [0:31]; //there is a zero reg with 0 value

	// first read then write (half write / half read)
	assign reg_data_1 = file[reg_read_1];
	assign reg_data_2 = file[reg_read_2];

	always @(posedge clk) begin
	//	// first read then write (half write / half read)
	//	reg_data_1 = file[reg_read_1];
	//	reg_data_2 = file[reg_read_2];
		
		if(write)
			if(reg_write!=0)
				file[reg_write] =  write_data;
			else
				$display("write on $0");
	end


	integer i;
	initial
		for(i=0; i <32; i = i+1)
			file[i]=i; // 0 but for test i use index

endmodule
