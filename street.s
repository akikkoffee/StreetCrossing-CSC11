.equ input, 0 // equate input to 0
.equ output, 1 // equate output to 1
.equ low, 0 // equate low to 0
.equ high, 1 // equate high to 1
.equ secpause, 5 // equate secpause to 5
.equ rtp, 25 // equate red traffic pin to gpio 25, phys 37
.equ ytp, 24 // equate yellow traffic pin to gpio 24, phys 35
.equ gtp, 23 // equate green traffic pin to gpio 23, phys 33
.equ rwp, 29 // equate red walking pin to gpio 29, phys 40
.equ gwp, 28 // equate green walking pin to gpio 28, phys 38
.equ startPin, 27 // equate start pin to gpio 27, phys 36

.align 4
.text
.global main

main:
	push {lr} // save return address on the stack
	bl wiringPiSetup // initialize the wiringPi library

	mov r0, #startPin // load start pin number into r0
	bl setPinInput // set the start pin as input

	mov r0, #rtp // load red traffic pin into r0
	bl setPinOutput // set red traffic pin as output
	bl pinOff // ensure red traffic pin is off

	mov r0, #ytp // load yellow traffic pin into r0
	bl setPinOutput // set yellow traffic pin as output
	bl pinOff // ensure yellow traffic pin is off

	mov r0, #gtp // load green traffic pin into r0
	bl setPinOutput // set green traffic pin as output
	bl pinOff // ensure green traffic pin is off

	mov r0, #gwp // load green walking pin into r0
	bl setPinOutput // set green walking pin as output
	bl pinOff // ensure green walking pin is off

	mov r0, #rwp // load red walking pin into r0
	bl setPinOutput // set red walking pin as output
	bl pinOff // ensure red walking pin is off

step1:

	mov r0, #rwp // load red walking pin into r0
	bl pinOn // turn on the red walking pin

	mov r1, #gtp // load green traffic pin into r1
	bl action // execute action for green traffic pin

	mov r0, #rwp // load red walking pin into r0
	bl pinOff // turn off the red walking pin

	mov r0, #gtp // load green traffic pin into r0
	bl pinOff // turn off the green traffic pin

	mov r0, #rtp // load red traffic pin into r0
	bl pinOn // turn on the red traffic pin

	mov r0, #gwp // load green walking pin into r0
	bl pinOn // turn on the green walking pin

	ldr r0, =10000 // load 10-second delay value into r0
	bl delay // delay for 10 seconds

step2:
	mov r0, #rtp // load red traffic pin into r0
	bl pinOff // turn off the red traffic pin

	mov r0, #gwp // load green walking pin into r0
	bl pinOff // turn off the green walking pin

	bl blink // call the blink function

step3:
	mov r0, #gtp // load green traffic pin into r0
	bl pinOn // turn on the green traffic pin

	mov r0, #rwp // load red walking pin into r0
	bl pinOn // turn on the red walking pin

	ldr r0, =10000 // load 10-second delay value into r0
	bl delay // delay for 10 seconds

	mov r0, #gtp // load green traffic pin into r0
	bl pinOff // turn off the green traffic pin

	mov r0, #rwp // load red walking pin into r0
	bl pinOff // turn off the red walking pin

	mov r0, #gtp // load green traffic pin into r0
	bl pinOff // ensure green traffic pin is off

	mov r0, #rwp // load red walking pin into r0
	bl pinOff // ensure red walking pin is off

	mov r0, #0 // set return value to 0
	pop {pc} // restore the return address and branch back

// sets a wiring pin as input
setPinInput:
	push {lr} // save return address
	mov r1, #input // set input mode
	bl pinMode // configure pin mode
	pop {pc} // restore return address

// sets a wiring pin as output
setPinOutput:
	push {lr} // save return address
	mov r1, #output // set output mode
	bl pinMode // configure pin mode
	pop {pc} // restore return address

// provides voltage to a pin
pinOn:
	push {lr} // save return address
	mov r1, #high // set pin to high voltage
	bl digitalWrite // turn pin on
	pop {pc} // restore return address

// stops voltage to a pin
pinOff:
	push {lr} // save return address
	mov r1, #low // set pin to low voltage
	bl digitalWrite // turn pin off
	pop {pc} // restore return address

// reads the start button state
readStartButton:
	push {lr} // save return address
	mov r0, #startPin // load start pin into r0
	bl digitalRead // read pin state
	pop {pc} // restore return address

// turns an LED on and waits for button press
action:
	push {r4, lr} // save r4 and return address
	mov r4, r1 // store pin number in r4
	bl pinOff // turn off the pin
	mov r0, r4 // reload pin number into r0
	bl pinOn // turn on the pin

loopy:
	bl readStartButton // check button state
	cmp r0, #high // compare to high state
	beq actionEnd // exit if button is pressed
	blt loopy // loop if not pressed
	mov r0, #0 // return 0

actionEnd:
	pop {r4, pc} // restore r4 and return address

// blinks yellow traffic LED and green walking LED
blink:
	push {r4, lr} // save r4 and return address
	mov r4, #7 // set blink count to 7

blinkLoop:
	cmp r4, #0 // check if counter is 0
	beq phase_3 // exit loop if counter is 0

	mov r0, #ytp // load yellow traffic pin into r0
	bl pinOn // turn on yellow traffic pin

	mov r0, #gwp // load green walking pin into r0
	bl pinOn // turn on green walking pin

	mov r0, #1000 // set 1-second delay
	bl delay // delay

	mov r0, #ytp // load yellow traffic pin into r0
	bl pinOff // turn off yellow traffic pin

	mov r0, #gwp // load green walking pin into r0
	bl pinOff // turn off green walking pin

	mov r0, #1000 // set 1-second delay
	bl delay // delay

	sub r4, #1 // decrement counter
	bal blinkLoop // loop until counter reaches 0
