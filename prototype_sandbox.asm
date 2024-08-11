
START LDA #0       ; Load accumulator with 0 (end of string marker)
     STA $80      ; Store it in memory location $80
     LDX $80      ; Load X register with index of end of string
LOOP LDA $80,X    ; Load character in accumulator
     CMP #32      ; Compare with space character
     BEQ NEXT     ; If space character, move to next word
     DEX          ; If not space character, move to previous character
     BNE LOOP     ; Loop until end of string is reached
     RTS          ; Return if end of string is reached
NEXT INX          ; Move to next character after space
     INY          ; Move to next position in output buffer
SPACE
     STY $90,X    ; Store current position in output buffer
     LDA #32      ; Load accumulator with space character
     STA $90,Y    ; Store space character in output buffer
     DEY          ; Move back to previous position in output buffer
     DEX          ; Move back to previous character in input buffer
     BPL SPACE    ; Loop until space character is found
     LDA $80      ; Reset input buffer pointer to next character
     STA $80,X
     DEY
     BPL LOOP
