
.ORG $0200

ROMAN_TO_INT:
    LDX #0      ; Initialize accumulator for integer calculation
    LDA #0
    
LOOP:
    LDY #0
    
    LDA INPUT, X ; Load character into A register
    CMP #'I'     ; Compare character with 'I'
    BEQ IS_I     ; If equal, go to IS_I
    CMP #'V'     ; Compare character with 'V'
    BEQ IS_V     ; If equal, go to IS_V
    CMP #'X'     ; Compare character with 'X'
    BEQ IS_X     ; If equal, go to IS_X
    CMP #'L'     ; Compare character with 'L'
    BEQ IS_L     ; If equal, go to IS_L
    CMP #'C'     ; Compare character with 'C'
    BEQ IS_C     ; If equal, go to IS_C
    CMP #'D'     ; Compare character with 'D'
    BEQ IS_D     ; If equal, go to IS_D
    CMP #'M'     ; Compare character with 'M'
    BEQ IS_M     ; If equal, go to IS_M
    
IS_I:           ; If character is 'I', add 1 to accumulator
    INX
    INY
    JMP CALCULATE
    
IS_V:           ; If character is 'V', add 5 to accumulator
    INX
    DEY
    DEY
    DEY
    JMP CALCULATE
    
IS_X:           ; If character is 'X', add 10 to accumulator
    INX
    INY
    INY
    JMP CALCULATE
    
IS_L:           ; If character is 'L', add 50 to accumulator
    INX
    DEY
    DEY
    DEY
    DEY
    DEY
    JMP CALCULATE
    
IS_C:           ; If character is 'C', add 100 to accumulator
    INX
    INY
    INY
    INY
    INY
    JMP CALCULATE
    
IS_D:           ; If character is 'D', add 500 to accumulator
    INX
    DEY
    DEY
    DEY
    DEY
    DEY
    DEY
    DEY
    DEY
    JMP CALCULATE
    
IS_M:           ; If character is 'M', add 1000 to accumulator
    INX
    INY
    INY
    INY
    INY
    INY
    JMP CALCULATE
    
CALCULATE:
    STA RESULT  ; Store accumulator value in RESULT
    LDA INPUT, X ; Load next character into A register
    CMP #0
    BEQ PRINT_RESULT
    JMP LOOP
    
PRINT_RESULT:
    LDX #0
    LDA RESULT
    STA OUTPUT, X   ; Store the integer result in OUTPUT
    RTS
    
INPUT:
    .BYTE 'M', 'D', 'C', 'L', 'X', 'V', 'I', 0
OUTPUT:
    .BYTE 0
RESULT:
    .BYTE 0

