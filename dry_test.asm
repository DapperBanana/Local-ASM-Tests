
START:
    LDX #0       ; Initialize X register to 0
    LDA #COEFFA  ; Load coefficient a into A register
    STA COEFFA   ; Store coefficient a in memory
    LDA #COEFFB  ; Load coefficient b into A register
    STA COEFFB   ; Store coefficient b in memory
    LDA #COEFFC  ; Load coefficient c into A register
    STA COEFFC   ; Store coefficient c in memory

    JSR CALC_DISCRIMINANT  ; Calculate the discriminant
    JSR CALC_ROOTS         ; Calculate the roots

    BRK

CALC_DISCRIMINANT:
    LDA COEFFB
    SEC
    SBC COEFFB
    STA DISCRIMINANT
    RTS

CALC_ROOTS:
    LDA DISCRIMINANT
    BMI NO_REAL_ROOTS  ; If discriminant < 0, no real roots

    LDX #0
    LDA COEFFB
    SEC
    SBC DISCRIMINANT
    CLC
    SBC COEFFC
    STA ROOT1

    LDX #1
    LDA COEFFB
    SEC
    SBC DISCRIMINANT
    CLC
    SBC COEFFC
    STA ROOT2

    RTS

NO_REAL_ROOTS:
    LDA #"No real roots"
    JSR PRINT_STRING
    RTS

PRINT_STRING:
    LDX #0
PRINT_LOOP:
    LDA ROOT1, X
    BEQ PRINT_DONE
    JSR PRINT_CHAR
    INX
    JMP PRINT_LOOP
PRINT_DONE:
    RTS

PRINT_CHAR:
    ; Code to print character in A register
    RTS

COEFFA: .byte 2
COEFFB: .byte 5
COEFFC: .byte 3
DISCRIMINANT: .byte 0
ROOT1: .byte 0
ROOT2: .byte 0
