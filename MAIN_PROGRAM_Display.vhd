library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;	 

entity Display is
	port(
	START_IN: IN STD_LOGIC;
	M_IN: IN STD_LOGIC;
	S_IN: IN STD_LOGIC;
	CLK_FPGA: IN STD_LOGIC;--CLK_IN must be
	
	Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
	AFISAJ: out std_logic_vector(0 to 6);
	SOUND_EX: out STD_LOGIC
	);
end Display;

architecture A_disp of Display is

component freq_div
	Port (clk : in STD_LOGIC;
	reset_n : in STD_LOGIC;
	clk_out : out STD_LOGIC);
end component;

component Proiect
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
	Sound: OUT STD_LOGIC
	);
    end component;		
signal SOUND_EXE,CLK,RESET: std_logic;
signal CLK_INT: std_logic:=CLK_FPGA;
--signal START_IN, M_IN, S_IN: std_logic:='0';
--signal START_int,M_int,S_int,CLK_int,SOUND: STD_LOGIC;
--constant X:std_logic:= M and S;
signal Afis0, Afis1, Afis2, Afis3: Std_logic_vector(0  to 6);   

signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0):="00000000000000000000";
signal LED_activating_counter: std_logic_vector(1 downto 0);
begin 
		
   	BEGINING: process(M_IN, S_IN)
	   begin
		   if(M_IN='1' and S_IN='1') then RESET <= M_IN and S_IN;end if;
	   end process BEGINING;
	
	   C0: freq_div port map (CLK_INT, RESET, CLK);
	   
	   FINAL: Proiect port map(RESET, START_IN, M_IN, S_IN,CLK, Afis0, Afis1, Afis2, Afis3, SOUND_EXE);

	--NEXT0: process(RESET)
	--begin
	  --if (RESET = '1') then AFISAJ<="0000000";	
	  --end if;
	--end process NEXT0;
	
	NEXT1: process(CLK_FPGA,RESET)
	begin 
    if(RESET='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(CLK_FPGA)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process NEXT1;			  

  NEXT12: LED_activating_counter <= refresh_counter(19 downto 18);

	NEXT2: process(LED_activating_counter)
	begin
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= "0111"; 
        AFISAJ <= Afis3;
    when "01" =>
        Anode_Activate <= "1011"; 
        AFISAJ <= Afis2;
    when "10" =>
        Anode_Activate <= "1101"; 
        AFISAJ <= Afis1;
     when "11" =>
        Anode_Activate <= "1110"; 
        AFISAJ <= Afis0;
     when others => Anode_Activate <= "1111";
    end case;	--invert 0 with 1 and 1 with 0
end process NEXT2;

BUZZER: SOUND_EX<= SOUND_EXE;

end A_disp;