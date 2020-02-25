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

entity Counter_VHDL is
	port(Zsec:in std_logic; 
	Clock: in std_logic;
	OK: in std_logic;
	Reset: in std_logic;
	Direction: in std_logic;
	Output0: out std_logic_vector(0 to 3);
	TCu,TCd: out std_logic;
	nul0:out std_logic;
	nul_next: in std_logic
	--zero:in std_logic;--delete it
	--Zsunet:out std_logic--delete it
	);
end Counter_VHDL;

architecture Behavioral of Counter_VHDL is
signal temp0: std_logic_vector(0 to 3);

begin
	
	Numarator0: process(Clock,Reset)
	--variable zero: integer := nul1 and nul2 and nul3;
	begin
		--nul0 <= '0'--delete it
	if Reset='1' then
		temp0 <= "0000"; nul0<='0';
	elsif ( rising_edge(clock) and OK='1') then
	    
	  if Direction='0' then
		if(temp0 = "1001") then
			temp0 <= "0000";
			TCu <= '1';
		else
			temp0 <= temp0 + 1;
			TCu <= '0';
		end if;
	elsif Direction='1' then
		--if (zero='1' and temp0 = "0000") then 
			--Zsunet<='1'; 
			--nul0<='1'; 
		--elsif
		if temp0 > "0001" then
				temp0 <= temp0 - 1;
				TCd <= '0';
		else if (temp0 = "0000" and nul_next='0') then	
			temp0 <= "1001";
			TCd <= '1';
			nul0 <= '0';
		else
			if (temp0 = "0001") then   --delete this if
			temp0 <= "0000";
			nul0<= '1';
			end if;
		
		end if;
		end if;
	end if;
	end if;
	end process Numarator0;
	Incrementare1: process(Zsec) 
	begin
	if (Zsec='1' and rising_edge(Clock)) then temp0<= temp0 + 1; 
		nul0<='1';
	end if;
	end process Incrementare1;
	Output0 <= temp0;
	
end Behavioral;