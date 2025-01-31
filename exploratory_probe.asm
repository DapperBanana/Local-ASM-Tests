
; Program to check if a given string is a valid credit card number
; Input: A = starting address of the string
; Output: Carry flag set if valid credit card number

    LDX #0              ; Initialize index counter
Loop:
    LDY 0,X             ; Load next character from the string
    CPY #0              ; Check if end of string
    BEQ Done            ; If end of string, exit loop
    
    CMP #'0'            ; Check if character is a digit
    BCC NotNumeric      ; If not a digit, skip to next character
    CMP #'9'
    BCS NotNumeric
    
    INX                 ; Increment index counter
    CPX #16             ; Check if reached 16 digits
    BEQ ValidCCNumber   ; If 16 digits, it is a valid credit card number
    JMP Loop            ; Continue checking the next character
    
NotNumeric:
    CLC                 ; Clear carry flag
    RTS                 ; Return
    
ValidCCNumber:
    SEC                 ; Set carry flag
    RTS                 ; Return
    
Done:
    CLC                 ; Clear carry flag
    RTS                 ; Return
