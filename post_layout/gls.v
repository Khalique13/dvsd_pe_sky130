`include "dvsd_pe.synthesis.v"
`timescale 1ns / 10ps
module test_dvsd_pe;

	reg [7:0] in;
	reg en;
 
	wire [2:0] out;
	wire eno, gs;
	
dvsd_pe uut (.in(in), .en(en), .out(out), .eno(eno), .gs(gs) );

initial begin
	$dumpfile("gls.vcd");	
	$dumpvars(0,test_dvsd_pe);
	
 in = 8'b00000000; en = 0; #10;
 in = 8'b00000001; en = 1; #10;
 in = 8'b00000010; en = 1; #10;
 in = 8'b00000100; en = 1; #10;
 in = 8'b00001000; en = 1; #10;
 in = 8'b00010000; en = 1; #10;
 in = 8'b00100000; en = 1; #10;
 in = 8'b01000000; en = 1; #10;
 in = 8'b10000000; en = 1; #10;

 end
endmodule
