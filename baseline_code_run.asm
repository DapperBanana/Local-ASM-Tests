
        .org $0200     ; Start address of program

MatrixA .byte $01, $02, $03
        .byte $04, $05, $06
        .byte $07, $08, $09

MatrixB .byte $01, $02, $03
        .byte $04, $05, $06
        .byte $07, $08, $09

Result  .byte 0, 0, 0
        .byte 0, 0, 0
        .byte 0, 0, 0

        CLD           ; Clear the decimal mode
        LDA #$03
        STA Rows       ; Number of rows in matrices
        LDA #$03
        STA Cols       ; Number of columns in matrices

        LDX #$00       ; Loop counter for rows
.RowLoop
        LDY #$00       ; Loop counter for columns
.ColLoop
        LDA #$00       ; Initialize accumulator for result
        STA Temp       ; Initialize temporary storage

        LDY #$00       ; Initialize inner loop counter
.InnerLoop
        LDA MatrixA,X  ; Load element from MatrixA
        CLC
        ADC MatrixB,Y  ; Add element from MatrixB
        STA Temp
        INX            ; Increment X
        INY            ; Increment Y
        CPY Cols       ; Compare Y with number of columns
        BNE .InnerLoop

        LDA Temp       ; Load final result to accumulate
        STA Result,X   ; Store result in Result matrix
        INX            ; Increment X
        CPX Rows       ; Compare X with number of rows
        BNE .ColLoop

        JMP .RowLoop   ; Continue with the next row

Temp    .byte $00
Cols    .byte $00
Rows    .byte $00

        .end
