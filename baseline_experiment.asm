
; Program to check if a given number is a Harshad (Niven) number

            .org $0200
start       LDA number       ; Load the given number into the accumulator
            STA temp         ; Store the number in a temporary location
            LDA #0           ; Clear the accumulator
            STA sum          ; Initialize the sum to 0
loop        LSR temp         ; Shift the number right to extract digits
            BCC end          ; If all digits have been extracted, jump to end
            CLC              ; Clear the carry flag
            ADC #$30         ; Convert the ASCII digit to numerical
            STA digit        ; Store the extracted digit
            LDA sum          ; Load the current sum
            ADC digit        ; Add the extracted digit to the sum
            STA sum          ; Store the updated sum
            JMP loop         ; Repeat the loop
end         LDA number       ; Reload the number into the accumulator
            CMP sum          ; Compare the original number with the sum
            BEQ is_harshad   ; If equal, it is a Harshad number
not_harshad LDA #0           ; Load 0 into the accumulator
            STA result       ; Set result to 0 (not a Harshad number)
            JMP done         ; Jump to the end
is_harshad  LDA #1           ; Load 1 into the accumulator
            STA result       ; Set result to 1 (Harshad number)
done        BRK              ; Exit the program

            .org $0300
number      .byte $15        ; Given number (change as needed)
temp        .byte $00        ; Temporary storage for the number
sum         .byte $00        ; Running sum of digits
digit       .byte $00        ; Extracted digit
result      .byte $00        ; Result of the check
