
.org $0600      ; Program start address

            LDX #0      ; Initialize X register to 0
            LDY #0      ; Initialize Y register to 0
loop        LDA str1,X  ; Load character from string 1
            CMP str2,X  ; Compare with character from string 2
            BNE mismatch ; Branch if characters are not equal
            INX         ; Increment X register
            CPX #strlen ; Check for end of string
            BNE loop    ; If not end, continue comparison
done        RTS         ; Return from subroutine

mismatch    INY         ; Increment Y register for each mismatch
            INX         ; Move to next character in strings
            CPX #strlen ; Check for end of string
            BNE loop    ; If not end, continue comparison
            JMP done    ; Jump to done if end of string is reached

str1        .asciiz "hello" ; String 1
str2        .asciiz "hallo" ; String 2
strlen      = *-str1      ; Length of strings

            .end        ; End of program
