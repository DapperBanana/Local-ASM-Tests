
ORG $6000  ; Start address of the program

START:
    LDX #$00  ; Initialize index for input string
    LDY #$00  ; Initialize index for word count array
    
    ; Load the address of input string into the zero page pointer
    LDA $6008  ; Address of input string lo byte
    STA $10    ; Store it at $10
    LDA $6009  ; Address of input string hi byte
    STA $11    ; Store it at $11
    
    ; Initialize word count array
    LDA #$00
    STA $0200,Y  ; Clear the word count array
    STA $0201,Y
    STA $0202,Y
    STA $0203,Y
    STA $0204,Y
    STA $0205,Y
    
LOOP:
    LDA ($10),X  ; Load a character from input string
    
    CMP #0      ; Check for end of string
    BEQ END
    
    CMP #32     ; Check for space character
    BEQ SPACE
    
    ; Increment word count for the current word
    INC $0200,Y
    
    INX         ; Move to the next character in the input string
    JMP LOOP
    
SPACE:
    INX         ; Skip the space character
    INC Y       ; Increment index for word count array
    JMP LOOP
    
END:
    ; End of string reached, print word counts
    LDY #$00
PRINT_LOOP:
    ; Load word count
    LDA $0200,Y
    STA $D000,Y    ; Store word count in memory for display
    
    INY
    CPY #$05    ; Check if all words counted
    BNE PRINT_LOOP
    
    ; End of program
    BRK

    ; Input string
    .DB "HELLO WORLD HELLO ASSEMBLY PROGRAMMING", 0

    ; Reserved space for word count
    .HS 00  ; Word count for "HELLO"
    .HS 00  ; Word count for "WORLD"
    .HS 00  ; Word count for "ASSEMBLY"
    .HS 00  ; Word count for "PROGRAMMING"
    .HS 00  ; Word count for any other word
