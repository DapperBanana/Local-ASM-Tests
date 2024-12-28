
        .org $0200

start   LDX #1              ; Load index register with 1
        LDY #0              ; Initialize Y register to 0
        LDAA $6000          ; Load the thousands digit of the year into A register
        CMPA #$00           ; Compare with 0
        BEQ check_hundreds  ; Branch if equal to 0
        INY                 ; Increment Y if thousands digit is non-zero

check_hundreds:
        LDAA $6001          ; Load the hundreds digit of the year into A register
        STAA $6200          ; Store it in memory location 6200
        LDAA $6002          ; Load the tens digit of the year into A register
        STAA $6201          ; Store it in memory location 6201
        LDAA $6003          ; Load the ones digit of the year into A register
        STAA $6202          ; Store it in memory location 6202

check_palindrome:
        LDA $6202,X         ; Load the ones digit of the year starting from the right
        CMP $6200,Y         ; Compare it with the hundreds digit
        BNE not_palindrome  ; Branch if not equal
        INX                 ; Increment X
        DEY                 ; Decrement Y
        CPY #0              ; Compare Y with 0
        BNE check_palindrome ; Loop until all digits checked

is_palindrome:
        LDX #1              ; Load index register with 1
        LDA #'Y'            ; Load ASCII code of 'Y' into A register
        STAA $6203          ; Store it in memory location 6203
        JMP end_program     ; Jump to end program
        
not_palindrome:
        LDA #'N'            ; Load ASCII code of 'N' into A register
        STAA $6203          ; Store it in memory location 6203

end_program:
        BRA end_program      ; Loop forever

        .org $6000
year    .byte $20,$22,$22,$20  ; Example year 2022

        .org $6200
digits  .ds 4                    ; Memory locations to store digits of year

        .end
