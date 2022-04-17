`timescale 1ns / 1ps

module adder_tb;

	// Inputs
	reg [7:0] A_in;
	reg [7:0] B_in;
	reg Sel_in;

	// Outputs
	wire [8:0] Rez_out;

	// Instantiate the Unit Under Test (UUT)
	adder uut (
		.A_in(A_in), 
		.B_in(B_in), 
		.Sel_in(Sel_in), 
		.Rez_out(Rez_out)
	);

	initial begin
		// Initialize Inputs
		A_in = 0;
		B_in = 0;
		Sel_in = 0;

		// Wait 100 ns for global reset to finish
		#5;
        
		// Add stimulus here
		
		// 2 + 3 = 5
		A_in = 8'b0000_0010;
		B_in = 8'b0000_0011;
		Sel_in = 0;
		#1;
		
		// 64 + 64 = 128
		A_in = 8'b0100_0000;
		B_in = 8'b0100_0000;
		Sel_in = 0;
		#1;
		
		// 5 - 2 = 3
		A_in = 8'b0000_0101;
		B_in = 8'b0000_0010;
		Sel_in = 1;
		#1;
		
		// 2 - 5 = -3
		A_in = 8'b0000_0010;
		B_in = 8'b0000_0101;
		Sel_in = 1;
		#1;
		
		// 2 + -10 = -8
		A_in = 8'b0000_0010;
		B_in = 8'b1000_1010;
		Sel_in = 0;
		#1;
		
		// 127 + 127 = 254
		A_in = 8'b0111_1111;
		B_in = 8'b0111_1111;
		Sel_in = 0;
		#1;
		
		// -128 - 127 = -255
		A_in = 8'b1000_0000;
		B_in = 8'b0111_1111;
		Sel_in = 1;
		#1;

	end
      
endmodule

