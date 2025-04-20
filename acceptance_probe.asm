
    ORG $0200
START:
    LDA #$00        ; Initialize accumulator to 0
    STA NUM+2       ; Clear high byte of number
    STA NUM+1       ; Clear middle byte of number
    LDA #$25        ; Load number to check (e.g., 25)
    STA NUM         ; Store low byte of number
    JSR IS_PERFECT_SQUARE ; Check if number is a perfect square
    BEQ PERFECT_SQUARE   ; Branch if number is a perfect square
NOT_PERFECT_SQUARE:
    ; Number is not a perfect square
    JMP $FFFC       ; End program
PERFECT_SQUARE:
    ; Number is a perfect square
    JMP $FFFC       ; End program

IS_PERFECT_SQUARE:
    ; Check if the given number is a perfect square
    LDA #$00        ; Initialize accumulator to 0
    LDX #$00        ; Initialize X register to 0
LOOP:
    LDA NUM,X      ; Load byte from number
    CMP #$00        ; Check if byte is 0
    BEQ END_LOOP    ; If byte is 0, end loop
    ADC ACC,X       ; Add byte to accumulator
    STA ACC,X       ; Store result in accumulator
    INX             ; Increment index
    JMP LOOP        ; Repeat loop
END_LOOP:
    CMP ACC         ; Compare accumulator with given number
    BEQ PERFECT     ; If accumulator is equal to the given number, it is a perfect square
    BNE NOT_PERFECT ; If accumulator is not equal to the given number, it is not a perfect square

PERFECT:
    RTS             ; Return from subroutine

NUM: .BYTE $00,$00,$00
ACC: .BYTE $00

    END START
