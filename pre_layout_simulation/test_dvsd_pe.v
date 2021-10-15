//  Testbench for 8-bit Priority Encoder
//  Copyright (C) 2021 Mohammad Khailique Khan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License. 

`timescale 1ns / 1ps
`include "dvsd_pe.v"

module test_dvsd_pe;

	reg en;
	reg [7:0] in;
	
 	wire eno, gs;
	wire [2:0] out;
	

 dvsd_pe uut (.in(in), .en(en), .out(out), .eno(eno), .gs(gs) );

initial begin
	$dumpfile("dvsd_pe.vcd");	
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
