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

entity num1 is
	port( up,down: in std_logic;
	Reset: in std_logic;
	--Direction: in std_logic;
	Output1: out std_logic_vector(0 to 3);
	TCu,TCd: out std_logic;
	nul1:out std_logic :='1';
	nul_next:in std_logic
	);
end num1;

architecture Behavioral of num1 is
signal temp0: std_logic_vector(0 to 3);

begin
	Numarator1: process(up,down,Reset)
	begin
	if Reset='1' then
		temp0 <= "0000";
		nul1 <= '1';
	elsif ( up = '1' ) then
		TCu <= '0';
		if(temp0 = "0101") then
			temp0 <= "0000";
			TCu <= '1';	
			nul1<= '0';
		else
			temp0 <= temp0 + 1;
			TCu <= '0';
			nul1<='0';
		end if;
	elsif down = '1' then
		TCd <= '0';
		if temp0 > "0001" then
			temp0 <= temp0 - 1;
			TCd <= '0';
		else
			if (temp0 = "0000" and nul_next='0') then
			temp0 <= "0101";
			TCd <= '1';
			nul1 <= '0';end if;
			if (temp0 = "0001") then ---delete this if
			temp0 <= "0000";
			if (nul_next = '1') then nul1<= '1'; end if;
			end if;
			end if;
		end if;
	end process Numarator1;
	Output1 <= temp0;
	
end Behavioral;