
        .segment "RESET"
        .org $FFFC
        .word START
        .segment "CODE"
START:
        SEI
        CLD
        LDA #$01
        STA $2000
        LDX #$07
LOOP:
        JSR RANDOM
        LDA $FE
        AND #$3F
        CMP #$20
        BEQ LOOP
        STA $0200,X
        DEX
        BPL LOOP
        LDA #$00
        STA $0200,X
        LDY #$FF
        STY $2001
        LDX #$08
LOOP2:
        LDA $0200,X
        JSR PRINT
        DEX
        BPL LOOP2
        LDA #$0D
        JSR PRINT
        LDA #$0A
        JSR PRINT

        JMP LOOP
RANDOM:
        STY $2001
        LDA $20
        AND #$01
        EOR $20
        ASL
        ROL $FD
        INY
        BNE RANDOM2
        INC $20
RANDOM2:
        RTS
PRINT:
        STY $2001
        STA $2000
        LDY #$05
PRINTLOOP:
        LDA $2000
        BPL PRINTLOOP
        LDA $2001
        BNE PRINTLOOP
        RTS
