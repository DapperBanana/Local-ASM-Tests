
        .text
        .globl _start

_start:
        LDX #0          ; Initialize X register to 0
        LDA num         ; Load the number to be processed
loop:
        BEQ done        ; If number is 0, exit loop
        ADC #0          ; Clear carry flag before sum
        CLC
        ADC #$30        ; Add ASCII offset to convert digit to number
        CMP #$3A        ; Check if the digit is greater than 9
        BCC add         ; If less than 10, add to X register
        SBC #$0A        ; Subtract 10 from the digit to convert to single digit
add:
        CLC
        ADC X           ; Add the digit to X register
        STA X           ; Store the sum in X register
        LSR             ; Shift right to extract the least significant digit
        STA num         ; Update the number with the next digit
        BRA loop        ; Repeat process for next digit
done:
        LDA X           ; Load the final sum
        STA result      ; Store the result
        BRK             ; End program

        .data
num:    .byte $32       ; Input number (ASCII code for "2")
result: .byte $00       ; Output sum
