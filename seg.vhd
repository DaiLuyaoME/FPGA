----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:20:12 11/18/2016 
-- Design Name: 
-- Module Name:    nixieTube - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nixieTube is
Port ( clk : in  STD_LOGIC;
--	start: in STD_LOGIC;
--	stop_contiue: in STD_LOGIC;
--	clear: in STD_LOGIC;
	rst : in  STD_LOGIC;
	sel : out  STD_LOGIC_VECTOR (7 downto 0);
	seg : out  STD_LOGIC_VECTOR (7 downto 0));
end nixieTube;

architecture Behavioral of nixieTube is

signal oneMil :STD_LOGIC := '0';
signal oneSec :STD_LOGIC := '0';
signal oneMin :STD_LOGIC := '0';
signal oneHour :STD_LOGIC := '0';
signal updateTube :STD_LOGIC := '0';
signal selectedBuffer: STD_LOGIC_VECTOR (7 downto 0):="00000001";
signal milLow : integer range 0 to 9 := 0;
signal milHigh : integer range 0 to 9 := 0;
signal secLow : integer range 0 to 9 :=0;
signal secHigh : integer range 0 to 9 :=0;
signal minLow : integer range 0 to 9 :=0;
signal minHigh : integer range 0 to 9 :=0;
signal hourLow : integer range 0 to 3 :=0;
signal hourHigh : integer range 0 to 2 :=0;
signal state: integer range 0 to 7:=0;

function interpret(signal dat:integer) return STD_LOGIC_VECTOR is
begin
case dat is
when 0 => return "00111111";
when 1 => return "00000110";
when 2 => return "01011011";
when 3 => return "01001111";
when 4 => return "01100110";
when 5 => return "01101101";
when 6 => return "01111101";
when 7 => return "00000111";
when 8 => return "01111111";
when 9 => return "01101111";
when others => return "00000000";
end case;
end interpret;

function choose(signal dat:integer) return STD_LOGIC_VECTOR is
begin
case dat is
when 0 => return "10000000";
when 1 => return "01000000";
when 2 => return "00100000";
when 3 => return "00010000";
when 4 => return "00001000";
when 5 => return "00000100";
when 6 => return "00000010";
when 7 => return "00000001";
when others => return "00000000";
end case;
end choose;



begin


--provide 0.01s clock
P0:process(clk,rst)
variable count: integer range 0 to 200000 :=0;
begin
if (rst='0') then
count:=0;
oneMil<='0';
elsif (rising_edge(clk)) then
count:=count+1;
oneMil<='0';
if(count=200000) then
count:=0;
oneMil<='1';
end if;
end if;
end process P0;


--provide 1s clock
P1:process(rst,oneMil)
begin
if (rst='0') then
milLow<=0;
milHigh<=0;
oneSec<='0';
elsif (rising_edge(oneMil)) then
	if milLow=9 then milLow<=0;
		if milHigh=9 then milHigh<=0;oneSec<='1';
		else milHigh <=milHigh+1;
		end if;
	else milLow<=milLow+1; oneSec<='0';
	end if;
end if;
end process P1;

-- provide a minute clock
P2:process(oneSec,rst)
begin
if (rst='0') then 
secLow <= 0;
secHigh <=0;
oneMin <='0';
elsif (rising_edge(oneSec)) then
	if secLow =9 then secLow <=0;
		if secHigh=5 then secHigh <=0;oneMin<='1';
		else secHigh <=secHigh+1;
		end if;
	else secLow<=secLow+1;oneMin<='0';
	end if;
end if;
end process P2;

-- provide an hour clock
P3:process(oneMin,rst)
begin
if (rst='0') then 
minLow <=0;
minHigh <=0;
oneHour <='0';
elsif (rising_edge(oneMin)) then
	if minLow =9 then minLow <=0;
		if minHigh=5 then minHigh <=0;oneHour<='1';
		else minHigh <=minHigh+1;
		end if;
	else minLow<=minLow+1;oneHour<='0';
	end if;
end if;
end process P3;

--provide 24 hour clock
P4:process(oneHour,rst)
begin
if (rst='0') then
hourLow<=0;
hourHigh<=0;
elsif (rising_edge(oneHour)) then
	if hourLow =3 then hourLow <=0;
		if hourHigh=5 then hourHigh <=0;
		else hourHigh <=hourHigh+1;
		end if;
	else hourLow<=hourLow+1;	
	end if;
end if;
end process P4;

--provide the clock to update tube, 1000Hz
upTube: process(rst,clk)
variable count: integer range 0 to 20000 :=0;
begin
if (rst='0') then
count:=0;
updateTube<='0';
elsif (rising_edge(clk)) then
count:=count+1;
updateTube <= '0';
if(count=20000) then
count:=0;
updateTube <= '1';
end if;
end if;
end process upTube;

display:process(rst,updateTube)

begin
if(rst='0') then
state<=0;
elsif(rising_edge(updateTube)) then
	case state is
	when 0 => seg <= interpret(milLow);sel<=choose(state);
	when 1 => seg <= interpret(milHigh);sel<=choose(state);
	when 2 => seg <= interpret(secLow);sel<=choose(state);
	when 3 => seg <= interpret(secHigh);sel<=choose(state);
	when 4 => seg <= interpret(minLow);sel<=choose(state);
	when 5 => seg <= interpret(minHigh);sel<=choose(state);
	when 6 => seg <= interpret(hourLow);sel<=choose(state);
	when 7 => seg <= interpret(hourHigh);sel<=choose(state);
	when others => null;
	end case;
	if (state=7) then state<=0;
	else state<=state+1;
	end if;
end if;

end process display;



end Behavioral;

