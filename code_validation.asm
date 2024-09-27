
.INCLUDE "6502.h"

    ORG $0200

start   LDA #10         ; Load the side length of the cube into the accumulator
        STA side        ; Store the side length in memory
        LDA side        ; Load the side length back into the accumulator
        JSR multiply    ; Call the multiply subroutine to calculate the surface area
        JSR print       ; Call the print subroutine to output the result
        BRK             ; Halt execution

multiply
        CLC             ; Clear the carry bit
        LDA side        ; Load the side length into the accumulator
        ASL             ; Multiply the side length by 6
        TAX             ; Transfer the result to the X register
        RTS             ; Return

print
        LDX #1          ; Set X to 1
loop    LDA $0200,X     ; Load the result from memory
        JSR $FFD2       ; Call the KERNAL routine to print the value
        INX             ; Increment X
        CPX #2          ; Compare X to 2
        BNE loop        ; Branch back to loop if not equal
        RTS             ; Return

side    .BYTE 0         ; Memory location to store the side length of the cube

    .END
