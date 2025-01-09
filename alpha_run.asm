
    .org $0200

start:
    LDX #0         ; Initialize counter to 0
    LDY #0         ; Initialize index to 0
    
compareLoop:
    LDA string1, Y  ; Load character from string1
    CMP string2, Y  ; Compare character with string2
    BEQ continue    ; If characters are equal, continue to next index
    
    INC X           ; Increment counter for each different character
    
continue:
    INY             ; Increment index
    CPY #strlen     ; Compare current index with string length
    BNE compareLoop ; If index is still less than length, continue comparison
    
    ; Counter now holds the Hamming distance
    ; Use the counter value as needed
    
    JMP end         ; End program

string1:
    .byte "Hello, world!", 0
string2:
    .byte "Hallo, world!", 0

strlen = * - string1

end:
    BRK             ; End of program
