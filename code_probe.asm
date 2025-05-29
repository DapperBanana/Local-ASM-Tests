
ORG $0200

LDA #$2A    ; Load the initial number (42) into the accumulator
STA num

sum_loop:
    LDX #$00        ; Clear X register to store the sum of digits
    LSR num         ; Shift right to get the least significant digit
    BCC get_digit   ; Branch if no more digits
    CLC
    ADC X           ; Add the digit to the sum
    BCC sum_loop    ; Branch if no carry
    INC X           ; Increment if carry
    STX sum

get_digit:
    LDA num
    STA temp_num
    LDA #$00
    STA sum
digit_loop:
    LDX #$00
    LSR temp_num
    BCC next_digit
    CLC
    ADC X
    BCC digit_loop
    INC X
    STA sum
    LDA temp_num
    STA temp_num
    LDX sum
    STA sum
    LDA #$00
next_digit:
    CMP #$00
    BEQ final_sum

final_sum:
    LDA sum        ; Load the final sum into the accumulator
    CMP #$09       ; Check if the sum is a single digit
    BEQ done       ; If it is, exit the program
    STA num        ; Store the sum back into the number
    BRA sum_loop   ; If not, repeat the process

done:
    BRK            ; End of program
num: .BYTE $00
sum: .BYTE $00
temp_num: .BYTE $00

ORG $FFFA
    .WORD $0200
