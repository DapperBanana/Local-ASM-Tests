
; 6502 Assembly Program to calculate the sum of the digits of a number until it becomes a single-digit number

START LDX #0         ; Initialize register X to zero
     LDY #0         ; Initialize register Y to zero
     LDA #123       ; Load the number to be processed (change this to desired input)
LOOP CMP #0         ; Compare the accumulator with zero
     BEQ DONE       ; Branch if the number has been reduced to a single digit
     LSR            ; Shift right to isolate the least significant digit
     CLC            ; Clear carry flag
     ADC #0         ; Add the least significant digit to the sum
     TAX            ; Transfer result to register X
     BCS ADDY       ; Branch if carry is set
     JMP LOOP       ; Continue processing the next digit

ADDY INX            ; Increment register Y to count the number of digits
     CPY #9         ; Compare to check if Y has exceeded 9
     BNE LOOP       ; Branch if not all digits have been processed
     LDX #0         ; Restore X to zero as we will process the sum of digits in the next loop

DONE STA RESULT     ; Store the final sum in a memory location
     ; Further processing or output of the final result can be done here

RESULT .BYTE 0       ; Memory location to store the final result

     ; Insert additional code here as needed

     BRK            ; Break and end the program
