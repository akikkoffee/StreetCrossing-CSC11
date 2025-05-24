# Traffic-Lights
Requirements:
- Raspberry Pi with Raspbian OS installed
- LEDs and wiring to connect to the GPIO pins
- Terminal access on the Raspberry Pi
- Program file (`street.s`)

Build Instructions:
Here are the instructions to wire the breadboard as I did such that the program controls it in the intended way:

[Initial Setup]
- Orient the breadboard so that the side with the red positive rail towards the outside is “left” and the side with the blue negative/ground rail pointing outside is “right”
- Connect Pin 2 on the Pi to the furthest hole on the positive power rail (the one adjacent to row 60) using a M-F wire (the kind with one side being a pin and one side being a hole)
- Connect Pin 6 (ground) to the ground rail hole right next to the previously used positive rail hole using a M-F wire. 

[Red Traffic Light Wiring]
- Connect Pin 37 on the Pi to hole A5 on the breadboard using a M-F wire
- Connect a 220 ohm resistor between B5 and C5
- Connect the long leg (anode) of a red LED into D5 and the short leg (cathode) into D6
- Connect E6 to the ground rail using a M-M wire (the kind with both sides being a pin)

[Yellow Traffic Light Wiring]
- Connect Pin 35 on the Pi to hole A10 on the breadboard using a M-F wire
- Connect a 220 ohm resistor between B10 and C10
- Connect the long leg (anode) of a yellow LED into D10 and the short leg (cathode) into D11
- Connect E11 to the ground rail using a M-M wire

[Green Traffic Light Wiring]
- Connect Pin 33 on the Pi to hole A15 on the breadboard using a M-F wire
- Connect a 220 ohm resistor between B15 and C15
- Connect the long leg (anode) of a green LED into D15 and the short leg (cathode) into D16
- Connect E16 to the ground rail using a M-M wire

[Red Pedestrian Light Wiring]
- Connect Pin 40 on the Pi to hole A20 on the breadboard using a M-F wire
- Connect a 220 ohm resistor between B20 and C20
- Connect the long leg (anode) of a red LED into D20 and the short leg (cathode) into D21
- Connect E21 to the ground rail using a M-M wire

[Green Pedestrian Light Wiring]
- Connect Pin 38 on the Pi to hole A25 on the breadboard using a M-F wire
- Connect a 220 ohm resistor between B25 and C25
- Connect the long leg (anode) of a green LED into D25 and the short leg (cathode) into D26
- Connect E26 to the ground rail using a M-M wire

[Button Wiring]
- Connect Pin 36 on the Pi to hole A30
- Place the button such that one side of the pins are in D30 and D32 and the other side crosses the central gap between the “left” and “right” sides of the breadboard, with the two remaining pins on the other side being inserted into G30 and G32
- **Connect H31 to the power rail using a M-M wire
- **Place a 10k ohm resistor between G31 and the hole on the ground rail adjacent to where you connected H31 on the power rail.
** CLASS NOTE: As explained in my submission video, my wiring configuration was not working until I removed the wire from H31 and the resistor from G31. I’m not quite sure why, but removing them allowed the lights to change as intended in one instance, though I was not able to record or recreate it, possibly due to hardware damage. 

Run Instructions:
1. Open the Terminal on your Raspberry Pi.
Click the terminal icon or find it in the menu.

3. Compile the program.
Run the following command to assemble the program
'g++ street.s -lwiringPi -g -o street`

4. Run the program
 	Enter ‘./street’

To Play:
Simply press the button and the program should cycle through the light cycle, assuming the board is wired correctly.
