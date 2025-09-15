
    ORG $0200
    
START:
    LDX #7              ; Initialize counter to 7
    LDA #$00            ; Initialize result to 0
    
CONVERT_LOOP:
    ASL                 ; Shift 1 bit to the left
    ROL result          ; Rotate shifted bit into result
    DEX                 ; Decrement counter
    BPL CONVERT_LOOP    ; Repeat until counter reaches 0
    
    ; Output result to screen
    STA $D020           ; Store result in memory location for screen output
    
    ; End program
    JMP END
    
result: .BYTE $00
    
END:
    BRK                 ; End program execution
