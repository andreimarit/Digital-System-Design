library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity proiect is
	port(
	RESET: IN STD_LOGIC;
	START: IN STD_LOGIC;
	M: IN STD_LOGIC;
	S: IN STD_LOGIC;
	CLK: IN STD_LOGIC;--CLK_IN must be 
	--AFISAJ: OUT STD_LOGIC_VECTOR(0 to 6);
	--T_astept: IN STD_LOGIC;
	--A0, A1, A2, A3: OUT STD_LOGIC;
	Afis0, Afis1, Afis2, Afis3: out Std_logic_vector(0  to 6);
	Sound: OUT STD_LOGIC);
end proiect;
																							 																	   
architecture behavior of proiect is

 

component UC
	port(
	START: IN STD_LOGIC;
	M: IN STD_LOGIC;
	S: IN STD_LOGIC;
	CLK: IN STD_LOGIC;
	T_astept: in std_logic;
	Zbut,Zblock,Zcres,Zdes,Zmin,Zsec:out std_logic
	);
end component;

component timer
	port(
	CLK: IN STD_LOGIC;
	OK: IN STD_LOGIC;
	RESET: IN STD_LOGIC;
	Direction:in std_logic;
	Output0,Output2,Output3: out std_logic_vector(0 to 3);
	Output1: out std_logic_vector(0 to 3);
	Zmin,Zsec: in std_logic;
	T_astept: out std_logic
	); 
end component;

component decoder
	port(
	Output0, Output1 ,Output2, Output3: in std_logic_vector(0 to 3);
	Afis0, Afis1, Afis2, Afis3: out std_logic_vector(0 to 6));
end component;


signal Zbut,Zblock,Zcres,Zdes,Zmin,Zsec,Zsunet,dir,OK,tas: std_logic;--add CLK after CLK_IN
signal Output0_int,	Output1_int, Output2_int, Output3_int: std_logic_vector(0 to 3);
signal Afis0_int, Afis1_int, Afis2_int, Afis3_int: std_logic_vector(0 to 6):="0000000";


begin
	
	
	C1: UC port map (START,M,S,CLK,tas,Zbut,Zblock,Zcres,Zdes,Zmin,Zsec);
	C2: dir <= not(Zcres) and Zdes;
	C3: OK <= Zcres or Zdes;
	C4: timer port map (CLK,OK,Zbut,dir,Output0_int,Output2_int,Output3_int,Output1_int,Zmin,Zsec,tas);
	C5: decoder port map(Output0_int,Output1_int, Output2_int, Output3_int, Afis0_int, Afis1_int, Afis2_int, Afis3_int);
	C61:Afis0<= Afis0_int;
	C62:Afis1<= Afis1_int;
	C63:Afis2<= Afis2_int;
	C64:Afis3<= Afis3_int;
	
	C7: process(tas, CLK)
	begin
		Sound <=tas;
	end process C7;
end behavior;