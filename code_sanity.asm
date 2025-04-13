
.org $0200

    LDA #4         ; load the number of sides of the tetrahedron
    STA SIDES

    LDA #3         ; load the length of each side of the tetrahedron
    STA SIDE_LEN

    LDA SIDE_LEN   ; load the side length into the accumulator
    JSR SQUARE     ; calculate the square of the side length
    STA TEMP       ; store the result in TEMP

    LDA SIDE_LEN   ; load the side length into the accumulator
    JSR MULTIPLY   ; calculate TEMP * SIDE_LEN
    STA TEMP       ; store the result in TEMP

    LDA TEMP       ; load the result into the accumulator
    JSR MULTIPLY   ; calculate TEMP * (SIDE_LEN / 3)
    STA TEMP       ; store the result in TEMP

    LDA TEMP       ; load the result into the accumulator
    JSR ROOT       ; calculate the square root of TEMP
    STA AREA       ; store the result in AREA

    BRK            ; break to end the program

SQUARE:
    CLC            ; clear the carry flag
    ADC #0         ; add the number in A to itself
    RTS            ; return from subroutine

MULTIPLY:
    CLC            ; clear the carry flag
    ADC TEMP       ; add TEMP to A
    RTS            ; return from subroutine

ROOT:
    LDX #16        ; set the initial guess to 16
    LDA #0         ; clear the accumulator
ROOT_LOOP:
    JSR DIVIDE     ; calculate TEMP / (2 * X)
    TAY            ; copy result to Y register
    LDA XVAL,Y
    PHA            ; push the value to the stack
    JSR MULTIPLY   ; calculate X * X
    LDA TEMP
    CMP #0         ; compare result to TEMP
    BCC ROOT_DONE  ; if less than TEMP, we are done
    STA TEMP       ; update TEMP with new value
    PLA            ; pop the value from the stack
    SBC #1         ; decrease X by 1
    BNE ROOT_LOOP  ; loop back if X is not 0
ROOT_DONE:
    RTS            ; return from subroutine

DIVIDE:
    LDA TEMP       ; load the dividend
    SEC            ; set the carry flag
    SBC #0         ; subtract 0 from the dividend
    LSR            ; shift right to divide by 2
    STA TEMP       ; store the quotient back in TEMP
    RTS            ; return from subroutine

XVAL:
    .byte $10,$08,$06,$04,$02,$01,$00,$00,$00

.area 0
TEMP: .byte $00
AREA: .byte $00
SIDE_LEN: .byte $00
SIDES: .byte $00

