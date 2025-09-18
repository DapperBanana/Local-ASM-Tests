
START:  LDA #6    ; Load the number for which factorial needs to be calculated
        JSR FACT  ; Call the recursive factorial function
        STA RESULT ; Store the result in memory
        
        BRK       ; End of program

FACT:   CMP #1    ; Check if the number is 1
        BEQ BASECASE
        
        SEC       ; Prepare for subtraction
        SBC #1    ; Subtract 1 from the number
        STA TEMP  ; Store the decremented number
        
        JSR FACT  ; Call the factorial function recursively
        
        LDY TEMP  ; Load the decremented number
        CLC       ; Clear carry before multiplication
        ADC RESULT ; Add the previous result
        STA RESULT ; Store the updated result
        
BASECASE:
        RTS       ; Return from recursive function
        
RESULT: .BYTE 0   ; Storage for the factorial result
TEMP:   .BYTE 0   ; Temporary storage for decremented number
