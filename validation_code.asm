
START:
    LDX #$00        ; Initialize sum of digits to 0
    LDY #$05        ; Load the value 5 as the input number
    
SUM_LOOP:
    LDA #0          ; Clear A register to store the remainder
    STA TEMP        ; Clear TEMP memory location to store the remainder
    
    CLC             ; Clear carry flag
    LDA Y           ; Load the input number into A register
    ADC #$00        ; Add carry to input number
    STA TEMP        ; Store the sum of the digits
    
DIGIT_LOOP:
    SBC #$0A        ; Subtract 10 from the sum of the digits
    BCC NO_OVERFLOW ; If no overflow, continue
    INC X           ; Increment the number of digits counted
    JMP DIGIT_LOOP  ; Jump back to DIGIT_LOOP
    
NO_OVERFLOW:
    BMI NEG_NUM     ; If the sum is negative, jump to NEG_NUM
    BNE CONTINUE    ; If not zero, continue
    
NEG_NUM:
    SEC             ; Set carry flag for subtraction
    SBC #$FF        ; Make it positive
    BNE CONTINUE    ; If not zero, continue
    
CONTINUE:
    LDY TEMP        ; Load the sum of the digits into Y
    CPY #$09        ; Compare sum to 9
    BEQ SINGLE_DIGIT; If equal to 9, jump to SINGLE_DIGIT
    
    CMP #$09        ; Compare sum to 9
    BNE SUM_LOOP    ; If not equal, go back to SUM_LOOP
    
SINGLE_DIGIT:
    STX RESULT      ; Store the result in RESULT memory location
    
END:
    BRK             ; Halt the program
    
TEMP:
    .BYTE $00       ; Temporary storage for remainder
RESULT:
    .BYTE $00       ; Storage for final result
