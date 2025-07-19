
        ORG $1000     ; Start address of our program
        NOP           ; No operation - placeholder for interrupt vector
Start:
        LDX #$00      ; Initialize index register X to 0
Loop:
        LDA Input,X   ; Load the character at index X from the input string
        CMP #$41      ; Compare the character with 'A'
        BCC NotLetter ; If the character is not a letter, skip to next iteration
        CMP #$5A      ; Compare the character with 'Z'
        BCS NotLetter ; If the character is not a letter, skip to next iteration
        STA Output,X ; Store the character in the output string
NotLetter:
        INX           ; Increment index register X
        CMP #$00      ; Check for end of string
        BEQ End       ; If end of string is reached, end the program
        JMP Loop      ; Otherwise, continue to the next iteration
End:
        BRK           ; Break and end the program
Input:
        .BYTE "Hello, world! This is a test string." ; Input string with punctuation
Output:
        .BLKB $20     ; Output string buffer
