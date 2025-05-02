
        .org $0200
start   LDX #0                  ; Initialize index to 0
        LDA string,X            ; Load the first character of the string
        BEQ end                 ; If the first character is empty, end program
        
check   CMP #'0'                ; Check if the character is a number
        BCS check_valid         ; If it is a number, check validity
        JMP invalid             ; If it is not a number, the string is invalid

check_valid
        CMP #'9'
        BCC next_char           ; If the number is between 0 and 9, check the next character
        JMP invalid             ; If the number is greater than 9, the string is invalid

next_char
        INX                     ; Move to the next character in the string
        LDA string,X            ; Load the next character
        BEQ end                 ; If the character is empty, end program
        JMP check               ; Check if the character is a valid number

invalid
        LDA #'0'                ; Return 0 in A register to indicate invalid string
        JMP end

end     STA result              ; Store the result in memory
        BRK

string  .asciiz "1234567890123456"  ; Change this to the desired credit card number
result  .byte 0                  ; Variable to store the result

        .org $02FF
        .word start
