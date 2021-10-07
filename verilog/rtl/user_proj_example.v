//  Here is the behavioral RTL code for 8-bit Priority Encoder
// 
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

module user_proj_example (io_in, io_en, io_out, wb_eno, wb_gs );

	//Inputs
	input [7:0]io_in;
	input io_en;
	//Outputs
	output reg [2:0]io_out;
	output wb_eno, wb_gs;
	
	
	wire _a_;

// Compiling enable outputs  
 assign _a_ = ~& io_in ;
 assign wb_eno = ~(_a_ & io_en);
 assign wb_gs = ~wb_eno & io_en;
 
always@(io_in, io_en)
	begin if (io_en)

		casex(io_in)
	
		
			8'b00000000:io_out = 3'bzzz;	//  Default Priority set at High Impedance 

		
			8'b00000001:io_out = 3'b000;	//	Lowest Priority
			8'b0000001x:io_out = 3'b001;
			8'b000001xx:io_out = 3'b010;
			8'b00001xxx:io_out = 3'b011;
			8'b0001xxxx:io_out = 3'b100;
			8'b001xxxxx:io_out = 3'b101;
			8'b01xxxxxx:io_out = 3'b110;
			8'b1xxxxxxx:io_out = 3'b111;	//	Highest Priority
		

			endcase
		end
	endmodule
`default_nettype wire


