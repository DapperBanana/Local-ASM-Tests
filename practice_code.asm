
QUADRATIC_EQUATION:
    LDA A      ; Load coefficient a into A
    STA COEFF_A
    LDA B      ; Load coefficient b into A
    STA COEFF_B
    LDA C      ; Load coefficient c into A
    STA COEFF_C

    JSR CALC_DISCRIMINANT  ; Calculate the discriminant
    JSR CALC_ROOTS         ; Calculate the roots

    JMP END_PROGRAM

CALC_DISCRIMINANT:
    LDA COEFF_B            ; Load coefficient b into A
    SEC
    SBC #0                 ; Subtract 0 from b
    STA B_SQUARED          ; Store b^2

    LDA COEFF_A            ; Load coefficient a into A
    LDA COEFF_C            ; Load coefficient c into A
    SEC
    SBC #0                 ; Subtract 0 from c
    STA DISCRIMINANT       ; Store the discriminant

    RTS

CALC_ROOTS:
    LDA B_SQUARED          ; Load b^2 into A
    SEC
    SBC DISCRIMINANT       ; Subtract the discriminant from b^2
    BPL ROOTS_REAL         ; If the result is positive, the roots are real
    JMP COMPLEX_ROOTS      ; Otherwise, the roots are complex

ROOTS_REAL:
    LDA COEFF_B            ; Load coefficient b into A
    SEC
    EOR B_SQUARED          ; XOR b^2
    SBC DISCRIMINANT       ; Subtract the discriminant
    LSR                    ; Shift the result right to divide by 2
    STA ROOT_1             ; Store the first root

    LDA COEFF_B            ; Load coefficient b into A
    LSR                    ; Shift b right to divide by 2
    STA ROOT_2             ; Store the second root

    RTS

COMPLEX_ROOTS:
    LDA COEFF_B            ; Load coefficient b into A
    SEC
    EOR B_SQUARED          ; XOR b^2
    SBC DISCRIMINANT       ; Subtract the discriminant
    LSR                    ; Shift the result right to divide by 2
    STA REAL_PART          ; Store the real part of the root

    LDA COEFF_B            ; Load coefficient b into A
    LSR                    ; Shift b right to divide by 2
    STA IMAG_PART          ; Store the imaginary part of the root

    RTS

END_PROGRAM:
    BRK

; Constants
COEFF_A: .BYTE 1
COEFF_B: .BYTE 2
COEFF_C: .BYTE 1

B_SQUARED: .BYTE 0
DISCRIMINANT: .BYTE 0

ROOT_1: .BYTE 0
ROOT_2: .BYTE 0

REAL_PART: .BYTE 0
IMAG_PART: .BYTE 0
