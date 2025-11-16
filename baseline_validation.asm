
; Quadratic equation solver in 6502 Assembly
;
; Equation: ax^2 + bx + c = 0
;
; Input:
; a = $00 (load with actual value)
; b = $01 (load with actual value)
; c = $02 (load with actual value)
;
; Output:
; x1 = $03 (first root)
; x2 = $04 (second root)

    .org $0200        ; Start address

    LDA $00           ; Load a
    STA $05           ; Store a in memory location $05

    LDA $01           ; Load b
    STA $06           ; Store b in memory location $06

    LDA $02           ; Load c
    STA $07           ; Store c in memory location $07

    ; Calculate discriminant (b^2 - 4ac)
    LDA $06           ; Load b
    ASL               ; Multiply b by 2 (b^2)
    ASL      
    STA $0A           ; Store b^2 in memory location $0A

    LDA $05           ; Load a
    LDA $07           ; Load c
    JSR multiply      ; Calculate 4ac
    STA $0B           ; Store 4ac in memory location $0B

    SEC               ; Set carry flag for subtraction
    LDA $0A           ; Load b^2
    SBC $0B           ; Subtract 4ac
    STA $08           ; Store discriminant in memory location $08

    ; Calculate roots
    LDA $08           ; Load discriminant
    BMI noRoots       ; If discriminant is negative, no real roots

    LDA $08           ; Load discriminant
    JSR squareRoot    ; Calculate square root
    STA $08           ; Store square root in memory location $08

    LDA $06           ; Load b
    CLC               ; Clear carry flag for addition
    ADC $08           ; Add square root
    LSR               ; Divide by 2
    STA $03           ; Store first root in memory location $03

    LDA $06           ; Load b
    SEC               ; Set carry flag for subtraction
    SBC $08           ; Subtract square root
    LSR               ; Divide by 2
    STA $04           ; Store second root in memory location $04

noRoots:
    BRK               ; End program

multiply:
    PHA               ; Store a on stack
    TAX               ; Copy a to X register
    LDA $07           ; Load c
    CLC               ; Clear carry flag for addition
    ADC $07           ; Add c
    TAX               ; Copy result back to X register
    PLA               ; Restore a from stack
    RTS               ; Return from subroutine

squareRoot:
    TAY               ; Copy square root to Y register
    LDX #08           ; Load initial guess for square root
loop:
    STX $0C           ; Store square in memory location $0C
    LDA $08           ; Load discriminant
    SEC               ; Set carry flag for subtraction
    SBC $0C           ; Subtract square
    BPL foundRoot     ; If result is positive or zero, exit loop
    SUB $0C           ; Subtract square
    STA $08           ; Store remainder in discriminant
    INX               ; Increment guess
    CPX #0A           ; Check if guess is too large
    BCC loop          ; Repeat loop if not
    RTS               ; Return from subroutine

foundRoot:
    TXA               ; Copy square root to accumulator
    TYA               ; Copy square to accumulator
    RTS               ; Return from subroutine
