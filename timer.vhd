library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity timer is
	port(
	CLK: IN STD_LOGIC;--CLK_INT
	OK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Direction:in std_logic;
	Output0,Output2,Output3: out std_logic_vector(0 to 3);
	Output1: out std_logic_vector(0 to 3);
	Zmin,Zsec: in std_logic;
	T_astept: out std_logic
	); 
end timer;

architecture Struct of timer is

component Counter_VHDL
	port( Zsec:in std_logic;
	Clock: in std_logic;
	OK:in std_logic;
	Reset: in std_logic;
	Direction: in std_logic;
	Output0: out std_logic_vector(0 to 3);
	TCu,TCd: out std_logic;
	nul0:out std_logic;
	nul_next: in std_logic
	--zero:in std_logic;--delete it
	--Zsunet:out std_logic--delete it
    );
end component;

component num1
	port( up,down: in std_logic;
	Reset: in std_logic;
	--Direction: in std_logic;
	Output1: out std_logic_vector(0 to 3);
	TCu,TCd: out std_logic;
	nul1:out std_logic;
	nul_next: in std_logic
	);
end component;

component num2
	port( Clock:in std_logic;
	Zmin: in std_logic;
	up,down: in std_logic;
	Reset: in std_logic;
	--Direction: in std_logic;
	Output2: out std_logic_vector(0 to 3);
	TCu,TCd: out std_logic;
	nul2:out std_logic;
	nul_next:in std_logic
	);
end component;

component num3
	port( up,down: in std_logic;
	Reset: in std_logic;
	--Direction: in std_logic;
	Output3: out std_logic_vector(0 to 3);
	nul3:out std_logic
	);
end component;

signal TCu0,TCd0,TCu1,TCd1,TCu2,TCd2,nul3,nul2,nul1,nul0:std_logic:= '0';
signal temp0:std_logic_vector(0 to 3);
signal temp2:std_logic_vector(0 to 3);
signal temp1, temp3: std_logic_vector(0 to 3);
--signal TT: std_logic :=T_astept;
begin
	
	--process
	--begin
		--if (T_astept='1') then RESET <= not(reset);
	--end if;
	--end process;
	
	N1:Counter_VHDL port map (Zsec,CLK,OK,RESET,Direction,temp0,TCu0,TCd0,nul0,nul1); --CLK_INT
	N2:num1 port map (TCu0,TCd0,RESET,temp1,TCu1,TCd1,nul1,nul2);
	N3:num2 port map (CLK,Zmin,TCu1,TCd1,RESET,temp2,TCu2,TCd2,nul2,nul3);
	N4:num3 port map (TCu2,TCd2,RESET,temp3,nul3);
	S:T_astept <= nul0 and nul1 and nul2 and nul3;
	Final1: Output0<=temp0;
	Final2: Output1<=temp1;	
	Final3: Output2<=temp2;	
	Final4: Output3<=temp3;	
end Struct;