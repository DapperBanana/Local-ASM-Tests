
; 6502 Assembly program to convert a binary number to decimal

START:
    LDX #7          ; Set counter to 7 for 8-bit binary number
    CLC             ; Clear carry flag for addition
    LDA #0          ; Initialize accumulator to 0 for result
LOOP:
    ASL             ; Shift left accumulator to multiply by 2
    ROL             ; Rotate left carry flag
    BCC SKIP        ; Branch if no carry to skip adding 1
    ADC #1          ; Add 1 if carry is set
SKIP:
    DEX             ; Decrement counter
    BNE LOOP        ; Loop until counter is 0

    ; Print the result in decimal format
    STA $FB         ; Store result in zero page memory location $FB
    LDX #2          ; Set counter to 2 for two decimal digits
PRINT_LOOP:
    LDA $FB         ; Load result back from memory
    LSR             ; Shift right to extract decimal digit
    LSR             ; Shift right again
    LSR             ; Shift right again
    STA $FE         ; Store extracted digit in zero page memory location $FE
    AND #$0F        ; Mask out upper nibble
    ADC #48         ; Convert to ASCII character
    JSR $FFD2       ; Print character
    LDA $FE         ; Load extracted digit back
    AND #$0F        ; Mask out lower nibble
    ADC #48         ; Convert to ASCII character
    JSR $FFD2       ; Print character
    DEX             ; Decrement counter
    BNE PRINT_LOOP  ; Loop until counter is 0

    BRK             ; End program

    .ORG $FFD2      ; Address of KERNAL routine for printing character
