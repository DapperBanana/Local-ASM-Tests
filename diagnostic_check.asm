
    LDA $2001  ; Load the length of the first list
    CLC
    STA $2002  ; Store it in memory
    LDX #$00    ; Initialize index for the first list

loop1:
    LDA $2000, X  ; Load element X from the first list
    STA $5000, X  ; Store it in the intersection list
    
    LDA $3001  ; Load the length of the second list
    CLC
    STA $3002  ; Store it in memory
    LDX #$00    ; Initialize index for the second list

loop2:
    LDA $3000, X  ; Load element X from the second list
    
    CMP $2000, X  ; Compare with element X from the first list
    BEQ intersection  ; If equal, store in the intersection list
    
    INX
    CPX $3001  ; Check if end of the second list
    BNE loop2   ; If not, continue with the next element
    
    INX
    CPX $2001  ; Check if end of the first list
    BNE loop1   ; If not, continue with the next element

intersection:
    INX
    CPX $3001  ; Check if end of the second list
    BNE loop2   ; If not, continue with the next element

done:
    BRK         ; End of program
