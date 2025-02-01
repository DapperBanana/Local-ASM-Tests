
; Check if a given number is a Harshad (Niven) number
; Input: X register contains the number to be checked
; Output: Carry flag set if the number is a Harshad (Niven) number, cleared otherwise

        LDA #0             ; Initialize sum to 0
        STA $00
check:  CLC                 ; Clear carry flag
        LDA $00             ; Load sum
        ADC X               ; Add least significant digit of the number
        STA $00             ; Store the new sum
        LSR                 ; Shift number right to get next digit
        BNE check           ; Loop until all digits processed

        LDA X               ; Load original number
        CMP $00             ; Compare with sum
        BCC not_harshad     ; Branch if original number is less than sum

        CLC                 ; Set carry flag if the number is a Harshad (Niven) number
        RTS

not_harshad:
        SEC                 ; Clear carry flag otherwise
        RTS
