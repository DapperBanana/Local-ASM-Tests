
        .org $0200

start:
        LDX #$00            ; Initialize total sum to 0
        LDA #$64            ; Load input number here (change to desired number)
loop:
        CMP #$00            ; Check if number is 0
        BEQ end             ; If number is 0, end program
        EOR #$30            ; Convert ASCII to decimal
        TAX                 ; Transfer number to X register
        CLC                 ; Clear carry flag
        LDA #$00            ; Reset accumulator
        ADC X               ; Add current digit to accumulator
        STA $00             ; Save sum in memory location $00
        LSR                 ; Divide current number by 10
        STA $01             ; Save quotient in memory location $01
        LDA $00             ; Load sum back into accumulator
        LDX $01             ; Load quotient back into X register
        JMP loop            ; Repeat loop

end:
        CMP #$00            ; Check if sum is divisible by original number
        BEQ is_harshad      ; If sum is 0, it is a Harshad (Niven) number
        RTS                 ; If sum is not 0, exit program

is_harshad:
        LDA #$01            ; Load message that number is a Harshad (Niven) number
        STA $0200           ; Store message in memory location $0200
        JMP $0200           ; Jump to message

        .text "Number is a Harshad (Niven) number"

        .org $FC00
        .byte $00           ; Input number here (change to desired number)
