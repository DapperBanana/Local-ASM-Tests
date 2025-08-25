
        .org $0600
START   LDX #NUMS
        LDY #NUMS+1
        STX CURR
        STY CURR+1
        LDA #0
        STA SUM
        STA SUM+1

LOOP    LDA (CURR),Y
        CLC
        ADC SUM
        STA SUM
        LDA (CURR),Y
        ADC SUM+1
        STA SUM+1
        INY
        CPY #LEN
        BNE LOOP

        LDX #LEN
        LSR X
        LDA (CURR),X
        STA MEDIAN

DONE    BRK

NUMS    .byte $03, $06, $02, $08, $05
LEN     = * - NUMS
CURR    .word 0
SUM     .word 0
MEDIAN  .byte 0
