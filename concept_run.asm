
    .org $0200              ; start program at address $0200

side    .byte $05            ; side length of the regular hexadecagon

    LDA side               ; load side length into accumulator
    ASL                   ; calculate side^2
    TAX                   ; save result in X register

    LDA #16                ; load constant 16 into accumulator
    JSR multiply           ; multiply side^2 by 16

    LDA $01                ; load value of pi from memory
    LDX #<$01              ; load low byte of memory address into X register
    LDY #>$01              ; load high byte of memory address into Y register
    JSR multiply           ; multiply result by pi/16

    JSR tan                ; calculate tangent of pi/16
    JSR divide             ; divide result by tangent of pi/16

    STA $02                ; save result in memory

    BRK                    ; end program

multiply:
    CLC
    ADC $00                ; multiply accumulator by memory
    ASL                    ; multiply result by 2
    ADC $01                ; add memory to result
    RTS

tan:
    LDX $00                ; load X register with high byte
    LDA $01                ; load low byte of memory into accumulator
    BNE .1                 ; skip next line if the low byte is not zero
    LDX $01                ; load X register with low byte
    LDA $00                ; load high byte of memory into accumulator
.1  STA $00                ; save high byte
    STX $01                ; save low byte
    LDA #$00               ; set accumulator to 0
.2  LSR                    ; divide accumulator by 2
    DEX                    ; divide X register by 2
    BNE .3                 ; skip next line if X register is not zero
    BNE .4                 ; skip next line if accumulator is not zero
    RTS
.3  STA $00                ; save quotient in memory
    STA $01                ; save remainder in memory
.4  BCC .2                ; repeat until carry is set to 1

divide:
    LDA $00                ; load high byte of dividend
    LDX $01                ; load low byte of dividend
    LDX #$00               ; set X register to 0
.5  CMP $02                ; compare dividend to divisor
    BCC .6                 ; skip next line if dividend is less than divisor
    SEC
    SBC $02                ; subtract divisor from dividend
    INX                    ; increment X register
    BNE .5                 ; repeat until dividend is less than divisor
.6  STX $01                ; save result in memory
    STA $00
    RTS

.pi:  .word $3243            ; value of pi

    .end
