module priority_encoder (
	//inputs
	input [7:0] in,
	input en,
	//outputs
	output [2:0] out,
	output gs,
	output eno );

//Declaring internal wires
wire a, b, c, d, e, f, g, h, i, j, k, l;

//Internal connection of the priority encoder
assign a = !en & !in[1] & in[2] & in[4] & in[6];
assign b = !en & !in[3] & in[4] & in[6];
assign c = !en & !in[5] & in[6];
assign d = !en & !in[7];

assign e = !en & !in[2] & in[4] & in[5];
assign f = !en & !in[3] & in[4] & in[5];
assign g = !en & !in[6];
assign h = !en & !in[7];

assign i = !en & !in[4];
assign j = !en & !in[5];
assign k = !en & !in[6];
assign l = !en & !in[7];

//Assiging final output pins
assign out[0] = !(a || b || c || d);
assign out[1] = !(e || f || g || h);
assign out[2] = !(i || j || k || l);

assign eno = !(!en && in);
assign gs = !eno || en;

endmodule
