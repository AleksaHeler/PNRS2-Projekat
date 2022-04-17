
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;


entity adder is
    Port ( A_in : in  STD_LOGIC_VECTOR (7 downto 0);
           B_in : in  STD_LOGIC_VECTOR (7 downto 0);
           Sel_in : in  STD_LOGIC;
           Rez_out : out  STD_LOGIC_VECTOR (8 downto 0));
end adder;

architecture Behavioral of adder is

begin
	-- Original:
	-- Rez_out <= (A_in(7) & A_in) + (B_in(7) & B_in);
	
	-- Go trough all posibilities - add/sub, B neg/pos
	-- If B is negative, convert to 2s complement
	-- Add 9th bit to signals, because output is 9bit
	process(A_in, B_in, Sel_in)
	begin
		if Sel_in = '0' and B_in(7) = '0' then
			-- B is positive, add
			Rez_out <= (A_in(7) & A_in) + (B_in(7) & B_in);
		elsif Sel_in = '0' and B_in(7) = '1' then 
			-- B is negative, add
			Rez_out <= (A_in(7) & A_in) + (B_in(7) & ( -B_in(6 downto 0) + '1'));
		elsif Sel_in = '1' and B_in(7) = '0' then
			-- B is positive, subtract
			Rez_out <= (A_in(7) & A_in) - (B_in(7) & B_in);
		else
			-- B is negative, subtract
			Rez_out <= (A_in(7) & A_in) - (B_in(7) & ( -B_in(6 downto 0) + '1'));
		end if;
	end process;
end Behavioral;

