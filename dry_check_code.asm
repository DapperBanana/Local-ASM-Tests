
START    LDX #0              ; Initialize index
         LDY #0              ; Initialize sum
         
LOOP     LDA NUMBER,X        ; Load current digit
         BEQ DONE            ; If end of number, jump to DONE
         SEC                 ; Clear carry flag
         SBC #48             ; Convert ASCII to decimal
         CMP #10             ; Check if digit is between 0 and 9
         BCS INVALID         ; If not, jump to INVALID
         
         ASL                 ; Double the current sum
         ADC Y               ; Add current digit to sum
         STA Y               ; Store new sum
         
         INX                 ; Increment index
         BNE LOOP            ; Continue the loop
         
DONE     CMP Y, NUMBER       ; Compare sum with original number
         BEQ IS_NARCISSISTIC ; If equal, jump to IS_NARCISSISTIC
         
INVALID  LDA #0              ; Set result to 0 (INVALID)
         STA RESULT
         JMP END             ; End program
         
IS_NARCISSISTIC
         LDA #1              ; Set result to 1 (NARCISSISTIC)
         STA RESULT
         
END      BRK                 ; End program
         
NUMBER   .BYTE 1, 6, 3, 5, 3, 6, 3 ; Number to check
RESULT   .BYTE 0              ; Result variable

         .ORG $FFFC          ; Set reset vector
         .WORD START         ; Start address
