
START:
    LDX #0            ; Initialize X register to hold the sum
    LDA NUMBER        ; Load the 8-bit number into the accumulator
LOOP:
    CMP #$00          ; Check if the number is zero
    BEQ DONE          ; If it is zero, exit the loop
    AND #$0F          ; Mask out the lower 4 bits to get the last digit
    CLC               ; Clear carry flag
    ADC X             ; Add the digit to the sum in the X register
    ROL               ; Shift the number right by 4 bits to get the next digit
    BNE LOOP          ; Continue looping until all digits are processed
DONE:
    STA RESULT        ; Store the sum in the RESULT memory location
    BRK               ; End of program

NUMBER:
    .byte $89         ; Input number to calculate sum of digits

RESULT:
    .byte $00         ; Memory location to store the sum

    .org $FFFC        ; Set reset vector
    .word START       ; Point reset vector to START address
