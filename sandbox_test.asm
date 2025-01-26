
; Program to calculate the area of a trapezoidal prism

.org $0200 ; Start address of the program

start:
    ldx #base1 ; Load base1 value into X register
    ldy #base2 ; Load base2 value into Y register

    lda #height ; Load height value into Accumulator

    ; Calculate the area of the trapezoidal prism: area = ((base1 + base2) / 2) * height
    clc
    lda base1 ; Add base1 to the Accumulator
    adc base2 ; Add base2
    tax ; Transfer the result to X register
    asl ; Multiply by 2
    adc #$00 ; Add carry
    tay ; Transfer the result to Y register

    ldx #0 ; Clear X register
    ldy #0 ; Clear Y register
    lsr ; Divide by 2
    adc #$00 ; Add carry

    jsr multiply ; Call multiply subroutine to multiply base by height

    ; Display the result
    lda $0201 ; Load the high byte of the result into the Accumulator
    jsr showHex ; Call the showHex subroutine to display the result
    lda $0200 ; Load the low byte of the result into the Accumulator
    jsr showHex ; Call the showHex subroutine to display the result

    rts ; Return from subroutine

multiply:
    ldx $0201 ; Load the high byte of base1*height into X register
    ldy #0 ; Clear Y register
    jsr mul8 ; Call multiply subroutine to multiply base1*height by 8
    lda #$00 ; Load the high byte of result into Accumulator
    clc
    adc $0200 ; Add low byte of base1*height
    sta $0202 ; Store the result in $0202
    
    ldx $0202 ; Load the result from $0202 into X register
    rts ; Return from subroutine
    
mul8:
    asl ; Multiply by 2
    rol ; Rotate left
    rol ; Rotate left
    rts ; Return from subroutine

base1: .byte 5 ; Define base1
base2: .byte 8 ; Define base2
height: .byte 6 ; Define height

include "showHex.asm" ; Include the showHex subroutine

.end ; End of the program
