`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module semafor(clk, reset_n, Sel_in, RGB_A, RGB_B);
    input clk;
    input reset_n;
    input [1:0] Sel_in;
    output reg [2:0] RGB_A;
    output reg [2:0] RGB_B;
	reg [11:0] my_timer;
	reg [11:0] my_timer_next;
	reg [1:0] state; // GREEN=0, G_TO_R=1, RED=2, R_TO_G=3

	always @(*) begin
		my_timer_next = my_timer + 1;
	end
	
	always @(posedge clk or reset_n)
		if(reset_n == 0) begin
			my_timer = 12'b0;
			state = 2'b00;
			RGB_A = 3'b001;
			RGB_B = 3'b100;
		end
		else begin
			my_timer <= my_timer_next;
			case(state)
				2'b00: begin // GREEN
					RGB_A = 3'b001;
					RGB_B = 3'b100;
					if(Sel_in == 0 && my_timer == 3000) begin
						state = 2'b01;
						my_timer = 0;
					end
					else if(Sel_in == 1 && my_timer == 4000)begin
						state = 2'b01;
						my_timer = 0;
					end
					else if(Sel_in == 2 && my_timer == 2000)begin
						state = 2'b01;
						my_timer = 0;
					end
				end
				2'b01: begin // G_TO_R
					RGB_A <= 3'b010;
					RGB_B <= 3'b010;
					if(my_timer == 700)begin
						state = 2'b10;
						my_timer = 0;
					end
				end
				2'b10: begin // RED
					RGB_A <= 3'b100;
					RGB_B <= 3'b001;
					if(Sel_in == 0 && my_timer == 3000) begin
						state = 2'b11;
						my_timer = 0;
					end
					else if(Sel_in == 1 && my_timer == 2000)begin
						state = 2'b11;
						my_timer = 0;
					end
					else if(Sel_in == 2 && my_timer == 4000)begin
						state = 2'b11;
						my_timer = 0;
					end
				end
				2'b11: begin // R_TO_G
					RGB_A <= 3'b010;
					RGB_B <= 3'b010;
					if(my_timer == 700)begin
						state = 2'b00;
						my_timer = 0;
					end
				end
			endcase
		end
endmodule