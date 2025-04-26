
.INCLUDE "6502.h"

.ORG $0200

START:
    LDA #10 ; base1
    STA $00
    LDA #12 ; base2
    STA $01
    LDA #5 ; height
    STA $02

    ; Calculate area of trapezoid
    LDA $00 ; base1
    CLC
    ADC $01 ; base2
    ADC $01 ; base1 + base2
    LSR ; divide by 2
    STA $03 ; store result in memory

    LDA $03 ; area
    CLC ; clear carry
    ADC $02 ; height
    STA $03 ; store result in memory

END:
    NOP
    JMP END

    .END
