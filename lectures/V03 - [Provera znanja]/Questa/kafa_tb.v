`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////


module kafa_tb;

	// Inputs
	reg clk=1'b0;
	reg reset_n=1'b1;
	reg coin_avail=1'b0;
	reg water_avail=1'b1;
	reg coffee_powder_avail=1'b1;
	reg plastic_glass_avail=1'b1;

	// Outputs
	wire plastic_glass;
	wire coffee_powder;
	wire hot_water;
	wire unlock;
	wire coin_return;

	// Instantiate the Unit Under Test (UUT)
	kafa uut (
		.clk(clk), 
		.reset_n(reset_n), 
		.coin_avail(coin_avail), 
		.water_avail(water_avail), 
		.coffee_powder_avail(coffee_powder_avail), 
		.plastic_glass_avail(plastic_glass_avail), 
		.plastic_glass(plastic_glass),
		.coffee_powder(coffee_powder), 
		.hot_water(hot_water), 
		.unlock(unlock), 
		.coin_return(coin_return)
	);

	initial begin
		// Initialize Inputs
		reset_n = 0;

		// Wait 1us for global reset to finish
		#1000;
		reset_n = 1;
        
		///////// First case: all is good /////////
		#10000000; // Wait 10m
		water_avail = 1;
		coffee_powder_avail = 1;
		plastic_glass_avail = 1;
		coin_avail = 1;
		#10000000; // Wait 10m
		coin_avail = 0;
		#1000000000; // Wait 1s
		
		
		///////// Second case: no water /////////
		#10000000; // Wait 10m
		water_avail = 0;
		coffee_powder_avail = 1;
		plastic_glass_avail = 1;
		coin_avail = 1;
		#10000000; // Wait 10m
		coin_avail = 0;
		#1000000000; // Wait 1s
		
		
		///////// Third case: no anything /////////
		#10000000; // Wait 10m
		water_avail = 0;
		coffee_powder_avail = 0;
		plastic_glass_avail = 0;
		coin_avail = 1;
		#10000000; // Wait 10m
		coin_avail = 0;
		#1000000000; // Wait 1s
		
	end
      

	// Clock cycle every 1000ns = 1us => 1MHz
	always #500 clk = ~clk;
		
endmodule
