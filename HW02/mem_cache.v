`timescale 1ns / 1ps

module mem_cache ( 
	input					 	clk,
	input			[31:0]	address,
	input			[127:0]	data_line,
	output reg	[31 :0]	instruction,
	output reg				hit
);
	// expand address line
	wire [24:0] addr_tag;
	wire [2 :0] addr_index;
	wire [1 :0] addr_offset;
	assign {addr_tag, addr_index, addr_offset} = address[31:2];

	reg [31:0] last_addr;
	reg [153:0] rows [0:7];

	integer counter = -1;

always @(posedge clk) begin
	case (addr_offset)
		2'b00: instruction = rows[addr_index][31  : 0];
		2'b01: instruction = rows[addr_index][63  : 32];
		2'b10: instruction = rows[addr_index][95  : 64];
		2'b11: instruction = rows[addr_index][127 : 96];
	endcase
	
	// check tag
	hit = rows[addr_index][152:128] == addr_tag && rows[addr_index][153]==1'b1;
end

always @(negedge clk) begin
	// check last tag/index pair to match prev
	if(address[31:4]!=last_addr[31:4]) begin
		last_addr = address;
		counter = 5;
	end else if(counter>=0)
		counter = counter - 1;
	
	if (counter == 1) begin
		rows[addr_index][153] = 1; // valid
		rows[addr_index][152:128] = addr_tag; // tag
		rows[addr_index][127:0] = data_line; // 4 * 32bit(word) instruction
	end
end

//initial begin : init_rows
//	integer i = 0;
//	for(i=0;i<8;i=i+1) begin
//		rows[i] = {1'b1,25'b0,32'd3,32'd2,32'd1,32'd0};
//	end
//		
//end

endmodule
