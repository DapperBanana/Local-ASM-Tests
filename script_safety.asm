
        .org $0200      ; Start program at memory address $0200

        LDX #VAR1       ; Load address of VAR1 into X register
        LDY #VAR2       ; Load address of VAR2 into Y register

        LDA (X),0       ; Load value of VAR1 into accumulator
        STA TEMP        ; Store value of VAR1 in TEMP

        LDA (Y),0       ; Load value of VAR2 into accumulator
        STA (X),0       ; Store value of VAR2 in VAR1

        LDA TEMP        ; Load value of VAR1 from TEMP into accumulator
        STA (Y),0       ; Store value of TEMP in VAR2

        BRK             ; End program

VAR1    .byte $12       ; Variable 1
VAR2    .byte $34       ; Variable 2
TEMP    .byte $00       ; Temporary variable

        .end            ; End of program
