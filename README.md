# ECE-520-LED-BLINKER-LAB-1
For this lab assignment we had to create a blinking LED by using switch s0-s2 on the Zybo-10 board.

For the design of the blinking LED it uses the 3 switches on the ZYBO board to decide which color should blink
It first checks whether exactly one switch us on or multiple swicthes
For the one switch that is on the module uses the system clock to create and out blink signal
The blink out alternates between a 1 and 0 every half clock cycle to create the blink affect
The case statement sends the input of 000,001,010,100, to its respective LED color
If no switches are on or multiple switches the LED is off
