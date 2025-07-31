
        .org $0200

start   LDX #$00        ; Initialize sum to zero
        LDA number      ; Load the number to be processed
loop    CMP #$30        ; Check if the current character is a digit
        BCC not_digit   ; If not, skip to the next character
        CMP #$3A
        BCS not_digit
        ADC #-$30       ; Convert ASCII digit to binary
        TAX             ; Save the digit in X register
        INX             ; Increment X to add it to sum
        TXA
        CLC
        ADC sum         ; Add digit to sum
        STA sum
not_digit
        INY             ; Move to the next character
        LDA number, Y   ; Load the next character
        CMP #$00        ; Check for end of string
        BNE loop        ; If not, continue processing
        LDA sum         ; Load the final sum
done    BRK             ; Exit program

number  .byte "12345"   ; Number to process
sum     .byte $00       ; Resulting sum

        .org $FFFC
        .word start
