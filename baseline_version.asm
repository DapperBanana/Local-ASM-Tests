
; Calculate the area of a trapezoid using 6502 Assembly

    ; Input variables
    ORG $0200       ; Starting address for program
    LDA #10         ; Base 1 of the trapezoid
    STA Base1
    LDA #6          ; Base 2 of the trapezoid
    STA Base2
    LDA #4          ; Height of the trapezoid
    STA Height

    ; Calculate area of trapezoid
    LDA Base1
    CLC
    ADC Base2      ; Add the two bases
    STA BasesSum
    LDA BasesSum
    STA Temp
    BEQ SkipMul    ; If sum of bases is 0, skip multiplication
    LDA Height
    CLC
    ADC Height     ; Calculate height * (base1 + base2)
    STA Temp       ; and store the result in Temp
    LDA Temp
    ADC Temp
    STA Temp
    LDA #$02
    JSR Multiply   ; Multiply result by 2 to get base1 + base2 * height
    
    LDA Temp
    STA Result     ; Save the final result in Result

    ; Output result
    LDA Result      ; Load result to accumulator
    STA $FF         ; Save result in memory location $FF

    ; Infinite loop
Loop:
    JMP Loop

; Function to multiply a 16-bit number
Multiply:
    LDA #$00
    STA ResultL     ; Clear low byte of result
    LDA Temp+1
    SEC
    SBC #$00        ; Carry = 1, Number of iterations = 16
LoopMult:
    ASL ResultL     ; Rotate result left by 1 bit
    ROL Temp        ; Rotate high byte of number left by 1 bit
    BCC SkipAdd     ; Skip adding value to ResultL if carry is clear
    LDA Base1
    CLC
    ADC ResultL     ; Add low byte of number to result
    STA ResultL     ; Store the new value
SkipAdd:
    DEC Temp
    BNE LoopMult

    RTS

    ; Variables
    Base1 .BYTE $00
    Base2 .BYTE $00
    Height .BYTE $00
    BasesSum .BYTE $00
    Temp .WORD $0000
    Result .WORD $0000
    ResultL .BYTE $00

    ; Interrupt vector
    .WORD $0200
