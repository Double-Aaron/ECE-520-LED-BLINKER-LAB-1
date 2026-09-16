
--VHDL logic types
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rgb_led_top is

generic (
clk_cycles_per_toggle : integer := 125000000-- clock set to 125MHZ
);

--port implementatiom
-- sysclk, system clock
--rst, system reset
-- sw, 3 switches 
-- rgb_out, output of led 3 possible outputs
port (
sysclk : in std_logic;
rst: in std_logic;
sw: in std_logic_vector(2 downto 0);
rgb_out: out std_logic_vector(2 downto 0)
);
end rgb_led_top;

architecture Behavioral of rgb_led_top is

signal blink_en: std_logic;-- blinking is enabled
signal blink_out: std_logic;-- output produuced by blinking_led

begin
blink_en <= '1' when (sw="001" or sw="010" or sw="100")-- blinking is only enabled when one switch is on
else '0';--else return 0

uut: entity work.blinking_led-- initiate the previous assignment 
generic map (
clk_cycles_per_toggle => clk_cycles_per_toggle-- pass down generic from rgb to blinking led
)

--port implementatiom
-- sysclk, system clock
--rst, system reset
--led_en, enables or disables blinking
--led_out, blinking output
port map(
sysclk => sysclk,
rst => rst,
led_en => blink_en,
led_out => blink_out
);

process(sw, blink_out)--process only runs when swicth is on or the output of led changes
begin

rgb_out <= "000";-- channels start off

case sw is
--red signal blinks
when "001" =>
rgb_out(0) <=blink_out;

--green signal blinks
when "010" =>
rgb_out(1) <=blink_out;

--blue signal blinks
when "100" =>
rgb_out(2) <=blink_out;

--every signal is turned off
when others =>
rgb_out <= "000";
end case;
end process;
end Behavioral;
