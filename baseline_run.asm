
ORG $0600

LDA String1
LDX #$00
STX CurrentPos
LengthLoop:
    LDA (String1),X
    CMP #$00
    BEQ DoneLength
    INX
    JMP LengthLoop

DoneLength:
    STA Str1Length

CheckNextString:
    LDX CurrentPos
    LDA String2
    LDY Str1Length
    CompareLoop:
        LDA (String2),X
        CMP (String1),X
        BNE DoneCheck
        INX
        DEY
        CPY #$00
        BNE CompareLoop

    DoneCheck:
        LDX CurrentPos
        STX CurrentPos
        CMP Str1Length
        BEQ CheckNextString

Done:
    RTS

String1:
    .ASC "abcdef"
    .BYTE $00

String2:
    .ASC "abcde"
    .BYTE $00

CurrentPos: 
    .BYTE $00

Str1Length: 
    .BYTE $00

