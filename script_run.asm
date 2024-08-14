
START LDA $2000   ; Load the starting address of string into accumulator
    STA $3000   ; Store it in another memory location
    
LOOP LDA $2000,X ; Load character of string into accumulator
    CMP #$41   ; Compare it with ASCII value of 'A'
    BCC NEXT   ; If less than 'A', skip this character
    CMP #$5A   ; Compare it with ASCII value of 'Z'
    BCS NEXT   ; If greater than 'Z', skip this character
    STA $3001,X ; Store the character in new memory location without punctuation
    
NEXT INX          ; Move to next character
    CPX #$0A   ; Compare with string length
    BNE LOOP   ; If not end of string, continue loop
    
    RTS       ; Exit program

    .ORG $2000        ; Starting address of string
    .DB "Hello, World!"     ; Sample string with punctuation
    
    .ORG $3000        ; New memory location to store string without punctuation
    .BLK 15          ; Allocate memory for new string
