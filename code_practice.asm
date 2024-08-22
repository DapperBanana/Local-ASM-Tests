
        ; Input: X = number to check if prime
        ; Output: Carry flag set if prime, clear if not prime

        LDX #2            ; Initialize divisor to 2
CHECK:
        CPX #2            ; Check if X == 2
        BEQ PRIME         ; If X == 2, it's prime

        CPX #1            ; Check if X == 1
        BEQ NOT_PRIME     ; If X == 1, it's not prime

        LDA X             ; Load X into A
        STA DIVIDEND      ; Store X in DIVIDEND
        JSR DIVISION      ; Perform division
        BCC NOT_PRIME     ; If quotient >= X, not prime

PRIME:
        CLC               ; Set carry flag to indicate prime
        RTS

NOT_PRIME:
        SEC               ; Clear carry flag to indicate not prime
        RTS

DIVISION:
        LDY #0            ; Initialize counter to 0
DIV_LOOP:
        LDA DIVIDEND      ; Load DIVIDEND into A
        SEC
        SBC DIVISOR       ; Subtract DIVISOR from A
        BCC DIV_END       ; If result is negative, exit loop
        INY               ; Increment counter
        JMP DIV_LOOP      ; Repeat until result is negative

DIV_END:
        LDA DIVIDEND      ; Load DIVIDEND into A
        SEC
        SBC DIVISOR       ; Subtract DIVISOR from A
        RTS

DIVIDEND: .BYTE 0       ; Variable to store dividend
DIVISOR:  .BYTE 0       ; Variable to store divisor
