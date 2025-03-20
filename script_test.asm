
        .org $0200
START   LDX #0
        LDY #0
GETCHAR LDA MESSAGE,Y
        BEQ DONE
        CMP #" "
        BEQ REVERSE
        INY
        BNE GETCHAR
REVERSE LDA #0
        STA TEMP
        DEY
REVLOOP LDY TEMP
        CMP MESSAGE,Y
        BNE REVLOOP2
        LDA MESSAGE,Y
        STA MESSAGE,X
        INX
        LDA #0
        STA MESSAGE,Y
REVLOOP2 LDX TEMP
        INX
        TXA
        CPY X
        BEQ GETCHAR
        LDX X
        STX TEMP
        JMP REVLOOP
DONE    BRK

MESSAGE .byte "Hello World!", 0
TEMP    .byte 0

        .end
