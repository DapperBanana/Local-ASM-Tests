
START:
    LDX #0          ; Initialize index register X to 0
    LDY #0          ; Initialize index register Y to 0
    
    ; Load the address of the string into the zero page
    LDA #<STRING
    STA $20
    LDA #>STRING
    STA $21
    
LOOP:
    LDA ($20),Y     ; Load a character from the string
    BEQ END         ; If the character is null, end the program
    
    INY             ; Increment Y to point to the next character
    
REVERSE_LOOP:
    DEY             ; Decrement Y to point back to the last character
    STX $22         ; Save the last character in zero page
    LDA ($20),Y     ; Load a character from the string
    STA ($20),X     ; Store the character in reverse order
    CPY #0          ; Check if Y is at the beginning of the string
    BNE REVERSE_LOOP ; If not, continue reversing the string
    
    STX ($20),Y     ; Store the first character of the reversed string
    INX             ; Increment X
    INY             ; Increment Y
    
    JMP LOOP        ; Continue looping through the string
    
END:
    BRK             ; End of program
    
STRING:
    .ASC "Hello, World!" ; String to be reversed
