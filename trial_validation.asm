
        .org $0200

        LDX #$00          ; Loop counters
outer_loop:
        LDY #$00

inner_loop:
        LDA matrix, x    ; Load element from matrix
        STA temp         ; Store element in temp variable

        LDA matrix2, y   ; Load element from transposed matrix
        CMP temp         ; Compare with element from original matrix
        BNE not_orthogonal   ; Branch if not equal

        INY              ; Increment inner loop counter
        CPY #$03         ; Check if reached end of matrix
        BNE inner_loop   ; Branch if not

        INX              ; Increment outer loop counter
        CPX #$03         ; Check if reached end of matrix
        BNE outer_loop   ; Branch if not

        ; If program reached here, matrix is orthogonal
        JMP orthogonal

not_orthogonal:
        ; If program reached here, matrix is not orthogonal
        JMP not_orthogonal

orthogonal:
        ; Matrix is orthogonal
        NOP

matrix  .byte $01, $02, $03, $02
        .byte $02, $04, $00, $00
        .byte $03, $00, $04, $00
        .byte $02, $00, $00, $06

matrix2 .byte $01, $02, $03, $02
        .byte $02, $04, $00, $00
        .byte $03, $00, $04, $00
        .byte $02, $00, $00, $06

temp    .byte $00

        .end
