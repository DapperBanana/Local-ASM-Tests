
; Program to calculate the Greatest Common Divisor (GCD) of two numbers
;
; Input:
; A - First number
; X - Second number
; Output:
; A - GCD of the two numbers

START:
    LDA #15         ; First number
    LDY #9          ; Second number
    
    JSR GCD         ; Calculate GCD
    
    ; Exit program
    BRK

; Subroutine to calculate GCD of two numbers
GCD:
    CMP #$00        ; Check if Y is 0
    BNE NEXT        ; If Y is not 0, continue
    
    ; Y is 0, so the GCD is A
    RTS
    
NEXT:
    SEC             ; Set carry flag for division
    SBC Y           ; Subtract Y from A
    BMI SWAP        ; If result is negative, swap A and Y
    
    ; Perform recursive function call
    JSR GCD
    
    ; Store result of previous call
    STA TEMP
        
    LDA Y           ; Load Y for division
    SEC             ; Set carry flag for division
    SBC TEMP        ; Subtract previous result from Y
    BEQ RETURN      ; If result is 0, return previous result
    BCC NEXT        ; If result is positive, continue recursion
    
SWAP:
    TYA             ; Swap A and Y
    TAX
    LDA TEMP
    TAY
    TXA

RETURN:
    RTS
    
; Variables
TEMP: .BYTE $00
