
        ; Binary to Decimal conversion program

NUM     .byte   %10011000      ; Binary number to convert (10011000 in binary)

START   LDX     #7              ; Set X register to 7 (number of bits in NUM)
        CLC                     ; Clear the carry flag
LOOP    LDA     NUM             ; Load the binary number
        ASL                     ; Shift left to multiply by 2 (B=2A)
        BCC     SKIP            ; Skip if no carry
        ADC     #1              ; Add 1 if carry set
SKIP    DEX                     ; Decrement  X
        BNE     LOOP            ; Loop until X = 0

        STA     RESULT          ; Store the decimal result
        BRK                     ; End program

RESULT  .byte   0               ; Decimal result

        .org    $FFFC           ; Reset vector
        .word   START           ; Start of program
