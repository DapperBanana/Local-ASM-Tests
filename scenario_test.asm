
.repeat equ 50
A equ $F0
B equ $00
C equ $FF

    .org $0600

start:
    LDX #0
    LDY #0
    sec
loop:
    ADC A,X
    SBC B,Y
    BMI up
    INY
    INX
    BNE loop
    JMP end
up:
    CPY C
    BCC notmax
    LDY #0
notmax:
    LDA A,X
    DEX
    BPL loop
end:
    STY $D020
    STX $D021
    LDA B,Y
    STA $D022
    LDA B,Y
    STA $D023
    STX $D024
    cli
    JMP ($FFFC)

    .org $FFFE
    .word start
