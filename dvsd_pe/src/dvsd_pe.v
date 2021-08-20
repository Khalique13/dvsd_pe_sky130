module dvsd_pe(in, en, out, eno, gs);
	//Inputs
	input [7:0]in;
	input en;
	//Outputs
	output reg [2:0]out;
	output eno, gs;
//Assigning enable outputs 
 assign eno = !(in & en);
 assign gs = !eno & en;
 
always@(in, en)
	begin if (en)

		casex(in)
	
		8'b00000001:out = 3'b000;
		8'b00000010:out = 3'b001;
		8'b00000100:out = 3'b010;
		8'b00001000:out = 3'b011;
		8'b00010000:out = 3'b100;
		8'b00100000:out = 3'b101;
		8'b01000000:out = 3'b110;
		8'b10000000:out = 3'b111;
		default:$display("Error!");

		endcase
	end
endmodule
