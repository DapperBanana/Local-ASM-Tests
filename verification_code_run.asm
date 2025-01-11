
    .org $0200
year    .byte   0
reversed_year .byte 0
result .byte 0

    .org $0300
    ldx #0
input_loop:
    lda $0200, x  ; Load input year digit
    tax
    cmp #10
    bcc digit
    RTS
    
digit:  clc
    ldx #0
    lda $0200, x  ; Load input year digit
    adc #1  ; Convert ASCII to numeric
    sta $0200, x  ; Store numeric digit
    inx
    bne next_digit
    RTS

next_digit: INX
    INX
    cpx #4  ; Check if we have read 4 digits
    BEQ process_year
    
process_year: LDX #3
    LDA #0
    STA reversed_year, x
reverse_loop: LDA $0200, x  ; Load digit from input year
    STA reversed_year, x  ; Store digit in reversed_year
    DEX
    BPL reverse_loop
    
    LDX #3
    LDA #0
check_loop: LDA $0200, x  ; Load digit from input year
    CMP reversed_year, x  ; Compare with reversed digit
    BNE not_palindrome
    DEX
    BPL check_loop
    
    LDA #1
    STA result
    
not_palindrome: STY $0301
    LDA result
    RTS
