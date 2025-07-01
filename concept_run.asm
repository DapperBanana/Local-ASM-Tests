
    ; Set up pointers to the two strings
    LDX #0         ; Initialize index for String 1
    LDY #0         ; Initialize index for String 2
    
nextChar:
    LDA str1,X    ; Load a character from String 1
    CMP #0         ; Check for null terminator
    BEQ end       ; If end of string, exit
    
    JSR checkChar  ; Check if character is in String 2
    
    INX            ; Move to next character in String 1
    JMP nextChar   ; Repeat for next character
    
checkChar:
    LDY #0         ; Reset index for String 2
    
nextChar2:
    LDA str1,X    ; Load a character from String 1
    CMP str2,Y    ; Compare with character from String 2
    BEQ match     ; If characters match, print and exit
    
    INY            ; Move to next character in String 2
    CMP #0         ; Check for end of String 2
    BNE nextChar2  ; Repeat if not end of String 2
    
    RTS           ; Return if no match found
    
match:
    STA $0200     ; Store matching character in memory for printing
    INY           ; Move to next character in String 2
    RTS           ; Return back
    
end:
    BRK           ; Exit program

str1:
    .asciiz "Hello"
    
str2:
    .asciiz "World"
