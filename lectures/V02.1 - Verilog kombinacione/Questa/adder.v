
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module adder(Rez_out, A_in, B_in, Sel_in);
    output [8:0] Rez_out;
	reg [8:0] Rez_out;
    input [7:0] A_in;
    input [7:0] B_in;
    input Sel_in;
	wire B_sign;
	wire [7:0] B_twos_comp;
	
	assign B_sign = B_in[7];
	assign B_twos_comp = ~B_in[6:0] + 1;
	
	always @(A_in or B_in or Sel_in)
		if (Sel_in == 0 && B_sign == 0) Rez_out = {A_in[7] ,A_in} + {B_in[7] ,B_in};
		else if (Sel_in == 1 && B_sign == 0) Rez_out = {A_in[7] ,A_in} - {B_in[7] ,B_in};
		else if (Sel_in == 0 && B_sign == 1) Rez_out = {A_in[7] ,A_in} + {B_twos_comp[7] ,B_twos_comp};
		else if (Sel_in == 1 && B_sign == 1) Rez_out = {A_in[7] ,A_in} - {B_twos_comp[7] ,B_twos_comp};
endmodule
