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

entity num2 is
	port( Clock:in std_logic;
	Zmin: in std_logic;
	up,down: in std_logic;
	Reset: in std_logic;
	--Direction: in std_logic;
	Output2: out std_logic_vector(0 to 3);
	TCu,TCd: out std_logic;
	nul2:out std_logic:='1';
	nul_next: in std_logic
	);
end num2;

architecture Behavioral of num2 is
signal temp0: std_logic_vector(0 to 3);

begin
	Numarator2: process(up,down,Reset, Zmin)
	begin
	if Reset='1' then
		temp0 <= "0000";
		nul2 <= '1';
	elsif ( up='1' ) then
		TCu <= '0';
		if(temp0 = "1001") then
			temp0 <= "0000";
			TCu <= '1';
		else
			temp0 <= temp0 + 1;
			TCu <= '0'; 
			nul2 <='0';
		end if;
	elsif down = '1' then
		TCd <= '0';
		if temp0 > "0001" then
			temp0 <= temp0 - 1;
			TCd <= '0';
		else	
			if(temp0 = "0000" and nul_next='0') then
			temp0 <= "1001";
			TCd <= '1';
			nul2 <= '0';
			end if;
			if (temp0 = "0001") then ---delete this if
			temp0 <= "0000";
			if (nul_next='1') then nul2<= '1'; end if;
			end if;
			end if;
		end if;
	end process Numarator2;													  
	Incrementare2: process(Zmin)
	begin
	if (Zmin='1' and rising_edge(Clock)) then temp0<= temp0 + 1; nul2<='0';
	end if;
	end process Incrementare2;
	
	Output2 <= temp0;
	
end Behavioral;