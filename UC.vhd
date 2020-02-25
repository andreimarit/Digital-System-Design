library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity UC is
	port(
	START: IN STD_LOGIC;
	M: IN STD_LOGIC;
	S: IN STD_LOGIC;
	CLK: IN STD_LOGIC;
	T_astept: in std_logic;
	Zbut,Zblock,Zcres,Zdes,Zmin,Zsec:out std_logic
	);
end UC;

architecture comp of UC is
type STARE_T is (ST0, ST1, ST2, ST3, ST4, ST5);
signal STARE, NXSTARE: STARE_T;
begin
	ACTUALIZEAZÃ_STARE: process (M, S, CLK)
	begin
		case M is
			when '1' => if S = '1' then
							STARE <= ST0;
						else
							STARE <= ST3;
						end if;
			when '0' => if S = '1' then
							STARE <= ST4;			
						elsif (rising_edge(CLK)) then
							STARE <= NXSTARE;
						end if;
			when others => STARE <= STARE;
		end case;
	end process ACTUALIZEAZÃ_STARE;
	
	TRANSITIONS: process (STARE, START, T_astept)
	begin
		case STARE is
			when ST0 => case START is
				when '1' => NXSTARE <= ST1;
				when others =>	NXSTARE <= ST0; end case;
				--CUT HERE		
			when ST1 => case START is
				when '0' =>	NXSTARE <= ST1;
			    when others =>	NXSTARE <= ST2; end case;
			when ST2 => case START is
				when '0' =>	NXSTARE <= ST2;
				when others =>	NXSTARE <= ST1; end case;
			when ST3 => case START is
				when '0' =>	NXSTARE <= ST3;
				when others =>	NXSTARE <= ST5; end case;
			when ST4 => case START is
				when '0' =>	NXSTARE <= ST4;
				when others =>	NXSTARE <= ST5; end case;
			when ST5 => 
				case START is
				when '1' => Zblock<='1'; NXSTARE <=ST3;
				when others => NXSTARE <= ST5;
				end case;
				case T_astept is 
				when '0' =>NXSTARE <=ST5;
				when '1' => NXSTARE <= ST0;
				when others => NXSTARE <= ST5;
			    end case;  
							    
		end case;
	end process TRANSITIONS;
	
	Output:process(STARE, M, S)
	begin
		Zbut <= '0'; Zcres <= '0'; Zblock <= '0'; Zmin <= '0'; Zsec <= '0'; Zdes <= '0';
		case STARE is
			when ST0 => Zbut <= '1';
			when ST1 => Zcres <= '1';
			when ST2 => Zblock <= '1';
			when ST3 => if (M = '1') then Zmin <= '1'; end if;
			when ST4 => if (S = '1') then Zsec <= '1'; end if;
			when ST5 => Zdes <= '1';	--when others => Zdes <= '1';
			when others => Zblock<='1';  --delete it
		end case;
	end process Output;
	
end comp;