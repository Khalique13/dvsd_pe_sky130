//  Verilog behavioral RTL code for 8-bit Priority Encoder
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


`default_nettype none

module dvsd_pe (en, in, eno, gs, out);

	input en;	//Enable Input
	input [7:0]in;	//8 Input line 
	
	output eno, gs;	//Enable outputs
	output reg [2:0]out;	//3 Output lines
	
	wire _a_;

// Compiling enable outputs  
 assign _a_ = ~& in ;
 assign eno = ~(_a_ & en);
 assign gs = ~eno & en;
 
always@(in, en)
	begin if (en)

		casex(in)
	
		// Default Priority set at High Impedance 
		8'b00000000:out = 3'bzzz;

		// Lowest Priority
		8'b00000001:out = 3'b000;
		8'b0000001x:out = 3'b001;
		8'b000001xx:out = 3'b010;
		8'b00001xxx:out = 3'b011;
		8'b0001xxxx:out = 3'b100;
		8'b001xxxxx:out = 3'b101;
		8'b01xxxxxx:out = 3'b110;
		8'b1xxxxxxx:out = 3'b111;
		// Highest Priority

		endcase
	end
endmodule

`default_nettype wire

