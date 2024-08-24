
        .org $0200

start   LDX #0              ; Initialize sum to 0
        LDA number          ; Load the number to be processed
loop    CMP #$30            ; Check if the current character is a digit
        BCC next            ; If not, skip to next character
        CMP #$3A
        BCS next
        CLC
        SBC #$30            ; Convert ASCII to numeric value
        ADC sum             ; Add the current digit to the sum
        STA sum
next    INX
        LDA number,X
        CMP #$00            ; Check for end of string
        BEQ done            ; If end of string, go to done
        JMP loop            ; Process next character
done    STY result
        BRK

number  .byte "12345", $00   ; Input number
sum     .byte 0              ; Sum of digits
result  .byte 0              ; Result stored here

        .org $FFFC
        .word start
