
; 6502 Assembly program to check if a given string is a valid palindrome sentence

    .org $0200

start:
    LDX #0              ; Initialize index for start of string
    LDY #0              ; Initialize index for end of string
    JSR read_input      ; Read input string
    
check_palindrome:
    CPX Y               ; Compare the two indices
    BCS end             ; If start index is >= end index, it's a palindrome
    
    LDA str,X           ; Load character from start index
    CMP str,Y           ; Compare with character from end index
    BEQ is_palindrome   ; If characters match, continue checking
    JMP not_palindrome   ; If characters don't match, it's not a palindrome
    
is_palindrome:
    INX                 ; Increment start index
    DEY                 ; Decrement end index
    JMP check_palindrome ; Continue checking characters
    
not_palindrome:
    LDA #$00            ; Load 0 to indicate it's not a palindrome
    BRK                 ; End program
    
end:
    LDA #$01            ; Load 1 to indicate it's a palindrome
    BRK                 ; End program
    
read_input:
    LDA #$00            ; Initialize null terminator for string
    STA str, X
    
input_loop:
    LDA $C000, X        ; Read character from input string
    STA str, X          ; Store character in string
    INX                 ; Increment string index
    CMP #$0A            ; Check for newline character
    BEQ end_input       ; If newline character, end input
    JMP input_loop      ; Continue reading input
    
end_input:
    RTS

str: .ds 100            ; String to store input

    .org $FFFC
    .word start
    .word $0000
