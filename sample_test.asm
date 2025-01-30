
LOOP: 
    LDX #10            ; Load the number of sides of the decagon
    LDA #360           ; Load the total degrees in a circle
    STA DEGREES        ; Store the total degrees in a circle
    JSR DIVIDE         ; Call the divide subroutine
    LDX #2D            ; Load the number of diagonals in a decagon
    JSR MULTIPLY       ; Call the multiply subroutine
    RTS

DIVIDE:
    LDA DEGREES        
    STA QUOTIENT       ; Set the quotient to total degrees in a circle
    LDX #5             ; Set the divisor to 5
LOOP1:
    CMP #0             ; Compare the quotient to 0
    BEQ END_DIVIDE     ; If quotient is 0, end the loop
    SEC
    SBC #1             ; Subtract divisor from quotient
    INC VALUE          ; Increment value by 1
    JMP LOOP1          ; Continue the loop
END_DIVIDE:
    RTS

MULTIPLY:
    LDA QUOTIENT      
    STA PRODUCT        ; Set the product to the quotient
LOOP2:
    DEX                ; Decrement X
    BNE END_MULTIPLY   ; Branch to end of loop if X is not zero
    INC PRODUCT        ; Increment product by 1
    JMP LOOP2          ; Continue the loop
END_MULTIPLY:
    RTS

DEGREES: .BYTE 0       ; Define variables
QUOTIENT: .BYTE 0
VALUE: .BYTE 0
PRODUCT: .BYTE 0
