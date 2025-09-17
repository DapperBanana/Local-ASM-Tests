
START    LDX #$00          ; Initialize index X to point to the first character of the string
         LDY #$0200        ; Initialize index Y to point to the string starting address  

LOOP     LDA (Y),X        ; Load the ASCII character from memory into the accumulator
         BEQ END          ; If end of string is reached, exit the loop
         CMP #$61          ; Compare ASCII character with 'a'
         BCC NOT_LOWER     ; If ASCII character is less than 'a', it is not a lowercase letter
         CMP #$7A          ; Compare ASCII character with 'z'
         BCS NOT_LOWER     ; If ASCII character is greater than 'z', it is not a lowercase letter
         SEC              
         SBC #$20          ; Convert lowercase letter to uppercase by subtracting 32
         STA (Y),X        ; Store the updated ASCII character back in memory    
          
NOT_LOWER INX              ; Move to the next character in the string
         JMP LOOP          ; Repeat the loop

END      RTS              ; Return from the subroutine
