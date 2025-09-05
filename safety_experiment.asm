
; Input:
; Matrix A:
;       | a b |
;       | c d |

; Outputs:
; Carry flag set if matrix is invertible

        .org $0600

matrix_a    .byte 2 ; a
            .byte 5 ; b
            .byte 3 ; c
            .byte 4 ; d

start       lda matrix_a
            sta $00       ; a
            lda matrix_a+1
            sta $01       ; b
            lda matrix_a+2
            sta $02       ; c
            lda matrix_a+3
            sta $03       ; d

            lda $00
            lda $03
            clc
            adc $01
            adc $02
            bcc invertible

not_invertible:
            sec
            rts

invertible:
            clc
            rts

            .end
