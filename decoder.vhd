library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;	 

entity decoder is
	port (
	Output0, Output1 ,Output2, Output3: in std_logic_vector(0 to 3);
	Afis0, Afis1, Afis2, Afis3: out std_logic_vector(6 downto 0));
end decoder;

architecture ARH of decoder is 
begin
	process (Output0)
	begin
		case Output0 is
			when "0000" => Afis0 <= "0000001";
			when "0001" => Afis0 <= "1001111";
			when "0010" => Afis0 <= "0010010";
			when "0011" => Afis0 <= "0000110";
			when "0100" => Afis0 <= "1001100";
			when "0101" => Afis0 <= "0100100";
			when "0110" => Afis0 <= "0100000";
			when "0111" => Afis0 <= "0001101";
			when "1000" => Afis0 <= "0000000";
			when "1001" => Afis0 <= "0000100";
			when others => Afis0 <= "0110000";
		end case;
	end process;

	process (Output1)
	begin
		case Output1 is
			when "0000" => Afis1 <= "0000001";
			when "0001" => Afis1 <= "1001111";
			when "0010" => Afis1 <= "0010010";
			when "0011" => Afis1 <= "0000110";
			when "0100" => Afis1 <= "1001100";
			when "0101" => Afis1 <= "0100100";
			when "0110" => Afis1 <= "0100000";
			when "0111" => Afis1 <= "0001101";
			when "1000" => Afis1 <= "0000000";
			when "1001" => Afis1 <= "0000100";
			when others => Afis1 <= "0110000";
		end case;
	end process;
	
	process (Output2)
	begin
		case Output2 is
			when "0000" => Afis2 <= "0000001";
			when "0001" => Afis2 <= "1001111";
			when "0010" => Afis2 <= "0010010";
			when "0011" => Afis2 <= "0000110";
			when "0100" => Afis2 <= "1001100";
			when "0101" => Afis2 <= "0100100";
			when "0110" => Afis2 <= "0100000";
			when "0111" => Afis2 <= "0001101";
			when "1000" => Afis2 <= "0000000";
			when "1001" => Afis2 <= "0000100";
			when others => Afis2 <= "0110000";
		end case;
	end process;
	
	process (Output3)
	begin
		case Output3 is
			when "0000" => Afis3 <= "0000001";
			when "0001" => Afis3<= "1001111";
			when "0010" => Afis3 <= "0010010";
			when "0011" => Afis3 <= "0000110";
			when "0100" => Afis3 <= "1001100";
			when "0101" => Afis3 <= "0100100";
			when "0110" => Afis3 <= "0100000";
			when "0111" => Afis3 <= "0001101";
			when "1000" => Afis3 <= "0000000";
			when "1001" => Afis3 <= "0000100";
			when others => Afis3 <= "0110000";
		end case;
	end process;
end ARH;	
