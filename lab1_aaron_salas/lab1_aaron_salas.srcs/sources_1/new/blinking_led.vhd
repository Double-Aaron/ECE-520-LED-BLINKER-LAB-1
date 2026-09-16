-- VHDL logic types
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity blinking_led is
-- 125 mhz clock /2 = 62.5 mhz
generic ( CLK_CYCLES_PER_TOGGLE : integer := 62500000);

--port implementatiom
-- sysclk, system clock
--rst, system reset
--led_en, enables or disables blinking
--led_out, blinking output
port (
sysclk : in std_logic;
rst : in std_logic;
led_en : in std_logic;
led_out : out std_logic
);

end blinking_led;

architecture Behavioral of blinking_led is

signal count: integer range 0 to CLK_CYCLES_PER_TOGGLE -1 := 0;-- counts the clock cycles
signal led_val: std_logic := '0';--remebers current LED state

begin
process(sysclk)--start when system clock starts

begin

if rising_edge(sysclk) then-- start on the rising edge of clock

if rst = '1' then-- if reset is on count and value both set to 0
count <= 0;
led_val <= '0';

elsif led_en ='0' then-- if blinking is disabled the counter is reset and the led is off
count <= 0;
led_val <= '0';

else if count = CLK_CYCLES_PER_TOGGLE -1 then-- when count reaches maximum turn o
count <= 0;
led_val <= not led_val;

else-- count to next clock cycle
count <= count +1;

end if;
end if;
end if;
end process;
led_out <= led_val;-- output led value
end Behavioral;
