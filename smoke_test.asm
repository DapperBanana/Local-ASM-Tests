
        .org $0200

start:
        LDA #16     ; Load the number to be converted
        JSR convertToRoman
        BRK         ; Stop program

convertToRoman:
        CMP #10
        BCC unitsPlace
        LDA #0
        STA $02     ; Set HUNDREDS flag to zero
        JMP tensPlace

unitsPlace:
        LDX #0
        LDA number
        CMP #10
        BCC getUnitNumeral
        LDA #9      
        STA number
        INC X
getUnitNumeral:
        LDA numeralList, X
        JSR printNumeral
        RTS

tensPlace:
        LDX #1
        LDA number
        CMP #10
        BCS getTensNumeral
        JMP unitsPlace
getTensNumeral:
        LDA numeralList, X
        JSR printNumeral
        LDA number
        CLC
        ADC #90
        STA number
        JMP unitsPlace

printNumeral:
        STA $00
        LDX #$00
        LDA (numeralList, X)
        CMP #$FF
        BEQ toConsole
        STX $01
nextPrint:
        INX
        LDA (numeralList, X)
        CMP #$FF
        BEQ toConsole
        LDA (numeralList, X)
        CMP #$FF
        BNE nextPrint
toConsole:
        LDA $00
        JSR $FFD2
        RTS

numeralList:
        .byte 'I','V','X','L','C', $FF

number:
        .byte 0

        .end
