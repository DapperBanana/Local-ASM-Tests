
        ORG $0200   ; Start program at memory location $0200

SIDE1   .BYTE $00    ; Define memory location for side 1
SIDE2   .BYTE $00    ; Define memory location for side 2
SIDE3   .BYTE $00    ; Define memory location for side 3
AREA    .WORD $0000  ; Define memory location for area (2 bytes)

START   LDA SIDE1     ; Load side 1 into the accumulator
        STA $FB       ; Store side 1 in zero page memory location $FB
        LDA SIDE2    ; Load side 2 into the accumulator
        STA $FC       ; Store side 2 in zero page memory location $FC
        LDA SIDE3    ; Load side 3 into the accumulator
        STA $FD       ; Store side 3 in zero page memory location $FD

        LDA $FB      ; Load side 1 from memory location $FB
        SEC           ; Set carry flag
        SBC $FC      ; Subtract side 2 from side 1
        STA $FE       ; Store result in memory location $FE
        LDA $FC     ; Load side 2 from memory location $FC
        SEC           ; Set carry flag
        SBC $FD      ; Subtract side 3 from side 2
        STA $FF       ; Store result in memory location $FF
        LDA $FD      ; Load side 3 from memory location $FD
        SEC           ; Set carry flag
        SBC $FB      ; Subtract side 1 from side 3
        STA $100      ; Store result in memory location $100

        LDA $FE     ; Load result of first subtraction into the accumulator
        SEC           ; Set carry flag
        SBC $FF      ; Subtract result of second subtraction
        STA $101      ; Store final result in memory location $101

        LDA $101     ; Load final result into the accumulator
        STA AREA     ; Store area in memory location AREA

        BRK           ; End program

        .END          ; End of program
