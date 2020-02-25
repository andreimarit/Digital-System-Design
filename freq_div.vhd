library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity freq_div is
Port (clk : in STD_LOGIC;
reset_n : in STD_LOGIC;
clk_out : out STD_LOGIC);
end entity freq_div;


architecture Behavioral of freq_div is
signal clk_sig : std_logic:='0';
begin

process(reset_n,clk)
variable cnt : integer:=0;
begin
if (reset_n='1') then
clk_sig<='0';
cnt:=0;
elsif rising_edge(clk) then
if (cnt=49999999) then
clk_sig<=NOT(clk_sig);
cnt:=0;
else
cnt:=cnt+1;
end if;
end if;
end process;


clk_out <= clk_sig;


end Behavioral;