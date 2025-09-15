
    .org $0200

    * Load data into memory
    LDA #$00
    STA $0200
    LDX #$00
    LDY #$10
    LDY #$00
LOOP LDA $C000,X
    STA $0300,Y
    INX
    INY
    CPX #$10
    BNE LOOP

    * Compress data
    LDA #$00
    STA $0400
    LDX #$00
    LDY #$01
NEXT LDA $0300,X
    CMP $0300,Y
    BEQ MATCH
    STA $0500,Y
    INY
    INC $0400
    JMP SKIP
MATCH INC $0400
    INY

SKIP INX
    CPX #$0F
    BNE NEXT

    * Output compressed data
    LDA #$00
    STA $0600
    LDX #$00
    LDA $0400
    STA $0601
DUMP LDA $0500,X
    STA $0602,X
    INX
    BNE DUMP

    * Done
    BRK

    .end
