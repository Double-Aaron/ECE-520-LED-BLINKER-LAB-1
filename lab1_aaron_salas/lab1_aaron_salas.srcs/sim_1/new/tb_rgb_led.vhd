
--import logic librarys
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--generates test signals internally no ports needed
entity tb_rgb_led is
end tb_rgb_led;

architecture Behavioral of tb_rgb_led is

constant clk_period: time := 8 ns;

--starting signal values rest start in high all other values are 0
signal sysclk : std_logic := '0';
signal rst : std_logic := '1';
signal sw: std_logic_vector(2 downto 0):= "000";
signal rgb_out : std_logic_vector(2 downto 0);


begin
uut: entity work.rgb_led_top-- rgb design under test
generic map(
CLK_CYCLES_PER_TOGGLE => 10--led toggles every 10 clock cycles
)
-- sysclk, system clock
--rst, system reset
-- sw, 3 switches 
-- rgb_out, output of led 3 possible outputs
port map(
sysclk => sysclk,
rst => rst,
sw => sw,
rgb_out => rgb_out
);

clk_process : process

--clock initialization high 1/2 low 1/2
begin
while true loop
sysclk <= '0';
wait for clk_period/2;

sysclk <= '1';
wait for clk_period/2;

end loop;
end process;

stim_process : process --test 
begin

--test#1 Reset
rst <= '1';
sw <="000";
wait for 5*clk_period;
rst<= '0';
wait for 5*clk_period;

--test #2 SW0 should be red
sw <="001";
wait for 25*clk_period;

--test#3 SW1 should be green
sw <="010";
wait for 25*clk_period;

--test #4 SW2 should be blue
sw <="100";
wait for 25*clk_period;

--test #5 all switches on 
sw <="111";
wait for 25*clk_period;

wait;
end process;
end Behavioral;
