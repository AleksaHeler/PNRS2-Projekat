`timescale 1ns / 1ps

module kafa(clk, 
			reset_n, 
			coin_avail, 
			water_avail, 
			coffee_powder_avail,
			plastic_glass_avail,
			plastic_glass,
			coffee_powder,
			hot_water,
			unlock,
			coin_return);

	// Sequential inputs
	input clk;
    input reset_n;
	
	// Coffee machine inputs
    input coin_avail;
    input water_avail;
    input coffee_powder_avail;
    input plastic_glass_avail;
    
	// Coffee machine outputs
	output reg plastic_glass;
	output reg coffee_powder;
	output reg hot_water;
	output reg unlock;
	output reg coin_return;
	
	// FSM internal variables
	reg [18:0] my_timer;
	reg [18:0] my_timer_next;
	reg [2:0] state; // IDLE=0, GET_GLASS=1, POUR_COFFEE=2, POUR_WATER=3, UNLOCK=4, COIN_RETURN=5
	wire has_ingredients;

	// Always have a signal notifying if all ingredients are present
	assign has_ingredients = water_avail & coffee_powder_avail & plastic_glass_avail;

	always @(*) begin
		my_timer_next = my_timer + 1;
	end
	
	always @(posedge clk or reset_n) begin
		if(reset_n == 0) begin
			my_timer = 12'b0;
			state = 3'b000; // IDLE
			plastic_glass = 1'b0;
			coffee_powder = 1'b0;
			hot_water = 1'b0;
			unlock = 1'b0;
			coin_return = 1'b0;
		end
		else begin
			my_timer = my_timer_next;
			case(state)
				3'b000: begin // IDLE
					if(coin_avail == 1) begin
						if(has_ingredients == 1) begin
							// Continue making coffee
							my_timer = 12'b0;
							state = 3'b001; // GET_GLASS
						end
						else begin
							// Return coin, no ingredients
							my_timer = 12'b0;
							state = 3'b101; // COIN_RETURN
						end
					end
				end
				3'b001: begin // GET_GLASS
					// Hold plastic_glass signal high for 200ms and go to next state
					plastic_glass = 1'b1;
					if(my_timer == 200000) begin // 200ms passed
						plastic_glass = 1'b0;
						my_timer = 12'b0;
						state = 3'b010; // POUR_COFFEE
					end
				end
				3'b010: begin // POUR_COFFEE
					// Hold coffee_powder signal high for 200ms and go to next state
					coffee_powder = 1'b1;
					if(my_timer == 200000) begin // 200ms passed
						coffee_powder = 1'b0;
						my_timer = 12'b0;
						state = 3'b011; // POUR_WATER
					end
				end
				3'b011: begin // POUR_WATER
					// Hold hot_water signal high for 200ms and go to next state
					hot_water = 1'b1;
					if(my_timer == 200000) begin // 200ms passed
						hot_water = 1'b0;
						my_timer = 12'b0;
						state = 3'b100; // UNLOCK
					end
				end
				3'b100: begin // UNLOCK
					// Hold unlock signal high for 200ms and go to idle
					unlock = 1'b1;
					if(my_timer == 200000) begin // 200ms passed
						unlock = 1'b0;
						my_timer = 12'b0;
						state = 3'b000; // IDLE
					end
				end
				3'b101: begin // COIN_RETURN
					// Hold coin_return signal high for 200ms and return to idle
					coin_return = 1'b1;
					if(my_timer == 200000) begin // 200ms passed
						coin_return = 1'b0;
						my_timer = 12'b0;
						state = 3'b000; // IDLE
					end
				end
			endcase
		end
	end
endmodule

