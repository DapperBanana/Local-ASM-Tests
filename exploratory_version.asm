
        .org $0200
start:  LDX #0          ; Initialize X index register to 0
        LDY #0          ; Initialize Y index register to 0
        LDA $0201, Y    ; Load the first character of the string into the accumulator
        BEQ done        ; If the string is empty, it is a palindrome
        
loop:   INY             ; Increment Y
        LDA $0201, Y    ; Load the next character of the string into the accumulator
        BEQ even_length ; If we reached the end of the string, it is a palindrome
        
        INX             ; Increment X
        CPY X           ; Compare X and Y
        BCC loop        ; If Y is less than X, continue looping
        
        LDA $0201, X    ; Load the character at position X into the accumulator
        CMP $0201, Y    ; Compare it with the character at position Y
        BNE not_palindrome ; If they are not equal, it is not a palindrome
        
        DEC X           ; Decrement X
        CPY X           ; Compare X and Y
        BCC loop        ; Continue looping if Y is less than X
        
even_length:
        LDA #1          ; Set the flag to indicate it is a palindrome
        JMP done        ; Jump to the end of the program

not_palindrome:
        LDA #0          ; Clear the flag to indicate it is not a palindrome

done:   BRK             ; End of the program

        .org $0300
string: .asciiz "abcba"  ; Define the input string

        .org $FFFC
        .word start     ; Set the reset vector to the start of the program
