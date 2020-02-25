library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity num3 is
	port( up,down: in std_logic;
	Reset: in std_logic;
	--Direction: in std_logic;
	Output3: out std_logic_vector(0 to 3);
	nul3: out std_logic:='1'
	);
end num3;

architecture Behavioral of num3 is
signal temp0: std_logic_vector(0 to 3);

begin
	Numarator3: process(up,down,Reset)
	begin
	if Reset='1' then
		temp0 <= "0000";
	elsif up='1' then
		if(temp0 = "1001") then
			temp0 <= "0000";
			nul3<='1';
		else
			temp0 <= temp0 + 1;
			nul3 <= '0';
		end if;
	elsif down = '1' then 
		if(temp0 = "0000") then
			nul3 <= '1';
		else
			if temp0 > "0001" then
			temp0 <= temp0 - 1;
		else
			if (temp0 = "0001") then ---delete this if
			temp0 <= "0000";
			nul3<= '1';
			end if;	
			end if;
		end if;
	end if;
	end process Numarator3;
	Output3 <= temp0;
	
end Behavioral;