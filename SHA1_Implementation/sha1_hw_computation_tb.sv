`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD 10
`define CLOCK_PERIOD 20
`define RESET_PERIOD 20
`define SIM_DURATION 2500

module sha1_hw_computation_tb();

logic clk, reset_n, write, read;
logic [5:0] address;
logic [31:0] writedata;
logic [31:0] readdata;


sha1_engine dut_0
(
	.clk(clk),
	.reset_n(reset_n),
	.write(write),
	.read(read),
	.address(address),
	.writedata(writedata),
	.readdata(readdata)
);
	

initial
begin
	clk = 1'b1;
	forever
	begin
		#`HALF_CLOCK_PERIOD clk = ~clk;
	end
end

initial
begin
	reset_n = 1'b0;
	#20 reset_n = 1'b1; 
	#`SIM_DURATION	$stop();
end

initial
begin
	#40
	write = 1'b1;
	read = 1'b0;
	
	// message - abc
	$display(" ------------------------ ");
	$display(" Initial Hash String... ");
	$display(" ------------------------ ");
	#20
	address = 2;
	writedata = 32'h67452301;
	$display("%x", writedata);
	#20
	address = 3;
	writedata = 32'hEFCDAB89;
	$display("%x", writedata);
	#20
	address = 4;
	writedata = 32'h98BADCFE;
	$display("%x", writedata);
	#20
	address = 5;
	writedata = 32'h10325476;
	$display("%x", writedata);
	#20
	address = 6;
	writedata = 32'hC3D2E1F0;
	$display("%x", writedata);
	
	$display(" ---------------------------------- ");
	$display(" Loading 16 words from Registers... ");
	$display(" ---------------------------------- ");
	#20
	address = 7;
	writedata = 32'h61626380;
	$display("%x", writedata);	
	#20
	address = 8;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 9;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 10;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 11;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 12;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 13;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 14;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 15;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 16;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 17;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 18;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 19;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 20;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 21;
	writedata = 32'd0;
	$display("%x", writedata);
	#20
	address = 22;
	writedata = 32'h18;
	$display("%x", writedata);
	
	$display(" ------------------------ ");
	$display(" Start SHA-1 Engine... ");
	$display(" ------------------------ ");
	
	#20
	address = 0;
	writedata = 32'd1;
	$display("%x", writedata);
	
	$display(" ------------------------ ");
	$display(" ------------------------ ");
	$display(" MESSAGE DISGIST (HASH) : ");
	$display(" ------------------------ ");
	$display(" ------------------------ ");
	#20
	write = 1'b0;
	#1620 
	read = 1'b1;
	address = 2;	
	#20 
	$display("%x", readdata);
	address = 3;
	#20 
	$display("%x", readdata);
	address = 4;
	#20 
	$display("%x", readdata);
	address = 5;
	#20 
	$display("%x", readdata);
	address = 6;
	#20 
	$display("%x", readdata);
	address = 1;
	$display(" -------------------------- ");
	$display(" Reading Status Register... ");
	$display(" -------------------------- ");
	#20
	$display("%x", readdata);
	address = 0;
	$display(" --------------------------- ");
	$display(" Reading Control Register... ");
	$display(" --------------------------- ");
	#20
	$display("%x", readdata);
	
	#20
	read = 1'b0;
	
end

endmodule
