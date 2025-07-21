
START:
    LDA #0
    STA A
    LDA #4
    STA B
    LDA #1
    STA C

    LDA B
    STA TEMP
    LDA TEMP
    ADD #0
    STA D

    LDA B
    STA E
    ASL
    STA F

    LDA C
    STA G
    ASL
    STA H

    LDA G
    STA I
    LDA I
    ADC F
    STA J
    ADC A
    STA K
    CLC
    LDA K
    ADC H
    STA K

    LDA E
    STA L
    LSR
    STA M
LOOP:
    LDA I
    ADC E
    STA I

    LDA J
    ADC G
    STA J

    DEC M
    BNE LOOP

    LDA I
    STA ROOT1

    LDA J
    STA ROOT2

    HLT

A:      .BYTE $00
B:      .BYTE $00
C:      .BYTE $00
D:      .BYTE $00
E:      .BYTE $00
F:      .BYTE $00
G:      .BYTE $00
H:      .BYTE $00
I:      .BYTE $00
J:      .BYTE $00
K:      .BYTE $00
L:      .BYTE $00
M:      .BYTE $00
ROOT1:  .BYTE $00
ROOT2:  .BYTE $00
TEMP:   .BYTE $00
