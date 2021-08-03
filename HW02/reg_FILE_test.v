`timescale 1ns / 1ps

module reg_FILE_test;

	// Inputs
	reg clk;
	reg write;
	reg [4:0] reg_read_1;
	reg [4:0] reg_read_2;
	reg [4:0] reg_write;
	reg [31:0] write_data;
	wire [31:0] reg_data_1;
	wire [31:0] reg_data_2;
	
	reg_FILE uut (
		.clk(clk), 
		.write(write), 
		.reg_read_1(reg_read_1), 
		.reg_read_2(reg_read_2), 
		.reg_write(reg_write), 
		.write_data(write_data), 
		.reg_data_1(reg_data_1), 
		.reg_data_2(reg_data_2)
	);
	

	initial forever #7 clk=~clk;

	initial begin
		clk = 0;
		reg_read_1 = 0;
		reg_read_2 = 0;
		write = 1;
		reg_write = 0;
		write_data = 0;
		#25;
		wait(clk==0); //stable
		
        
		reg_read_1 = 7;
		reg_read_2 = 5;
		write = 0;
		reg_write = 6;
		write_data = 0;
		
		wait(reg_data_1==7);
		wait(reg_data_2==5);
		#10;

        
		reg_read_1 = 5;
		reg_read_2 = 7;
		reg_write = 9;
		write_data = 1374;
		write = 1;
		
		wait(reg_data_1==5);
		wait(reg_data_2==7);
		#15;
		write = 0;
		#10;

		wait(clk==0); 
		#5;
		reg_read_1 = 12;
		reg_read_2 = 9;
		reg_write = 12;
		write_data = 74;
		write = 1;
		
		wait(reg_data_1==12);
		wait(reg_data_1==74);
		wait(reg_data_2==1374);
		#10;
		write = 0;
		#10;

		reg_read_1 = 9;
		reg_read_2 = 12;
		reg_write = 0;
		write_data = 25;
		write = 1;
		wait(reg_data_1==1374);
		wait(reg_data_2==74);
		#10;
		write = 0;
		#10;

		reg_read_1 = 0;
		reg_read_2 = 0;
		reg_write = 0;
		write = 1;
		wait(reg_data_1==0);
		wait(reg_data_2==25);
		#10;
		write = 0;
		#10;
		

	end
      
endmodule

