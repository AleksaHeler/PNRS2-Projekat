----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity semafor is
    Port ( clk : in  STD_LOGIC;
		reset_n : in  STD_LOGIC;
		Sel_in : in  STD_LOGIC_VECTOR (1 downto 0);
		RGB_A : out  STD_LOGIC_VECTOR (2 downto 0);
		RGB_B : out  STD_LOGIC_VECTOR (2 downto 0)
	);
end semafor;

architecture Behavioral of semafor is
	TYPE State_type IS (RED, RED_TO_GREEN, GREEN, GREEN_TO_RED);	-- Define the states
	SIGNAL State : State_Type;    									-- Create a signal that uses the different states
	SIGNAL Timer : STD_LOGIC_VECTOR(11 downto 0) := "000000000000";	-- For 100Hz & 40s max time, 12 bits is needed
begin
	process(clk, reset_n)
	begin
		if (reset_n = '1') then
			-- RESET
			timer <= (others => '0');
			State <= RED;
			RGB_A <= "100";
			RGB_B <= "001";
		elsif rising_edge(clk) then
			-- RISING EDGE -> FINITE STATE MACHINE
			Timer <= Timer + 1;
			case State is
				when RED =>
					RGB_A <= "100";
					RGB_B <= "001";
					case Sel_in is
						when "00" =>
							-- If timer runs for 30 seconds, reset it and change state
							if Timer >= "101110111000" then
								Timer <= (others => '0');
								State <= RED_TO_GREEN;
							end if;
						when "01" =>
							-- If timer runs for 20 seconds, reset it and change state
							if Timer >= "011111010000" then
								Timer <= (others => '0');
								State <= RED_TO_GREEN;
							end if;
						when others =>
							-- If timer runs for 40 seconds, reset it and change state
							if Timer >= "111110100000" then
								Timer <= (others => '0');
								State <= RED_TO_GREEN;
							end if;
					end case;
				when RED_TO_GREEN => 
					RGB_A <= "010";
					RGB_B <= "010";
					-- If timer runs for 7 seconds, reset it and change state
					if Timer >= "001010111100" then
						Timer <= (others => '0');
						State <= GREEN;
					end if;
				when GREEN => 
					RGB_A <= "001";
					RGB_B <= "100";
					-- If timer runs for X seconds, reset it and change state
					case Sel_in is
						when "00" =>
							-- If timer runs for 30 seconds, reset it and change state
							if Timer >= "101110111000" then
								Timer <= (others => '0');
								State <= GREEN_TO_RED;
							end if;
						when "01" =>
							-- If timer runs for 40 seconds, reset it and change state
							if Timer >= "111110100000" then
								Timer <= (others => '0');
								State <= GREEN_TO_RED;
							end if;
						when others =>
							-- If timer runs for 20 seconds, reset it and change state
							if Timer >= "011111010000" then
								Timer <= (others => '0');
								State <= GREEN_TO_RED;
							end if;
					end case;
				when GREEN_TO_RED => 
					RGB_A <= "010";
					RGB_B <= "010";
					-- If timer runs for 7 seconds, reset it and change state
					if Timer >= "001010111100" then
						Timer <= (others => '0');
						State <= RED;
					end if;
				when others =>
					timer <= (others => '0');
					State <= RED;
			end case;
		end if;
	end process;
end Behavioral;

