
        .org $0200

        LDX #0
outer:  LDA #$00
        STA $2080,X
        STA $2081,X
        STA $2082,X

        LDA $2000,X
inner:  LDY #0
        LDX #0
        STA $4000

        LDA $2040,Y
        CLC
        ADC $4000
        STA $4000
        
        INY
        BNE inner    ; Loop until Y reaches 3

        STA $2080,X   ; Store the result in memory

        INX
        INX
        INX
        INX
        BNE outer    ; Loop until X reaches 9

        RTS

        .org $2000
matrix1: 
        .byte 1, 2, 3
        .byte 4, 5, 6
        .byte 7, 8, 9

        .org $2040
matrix2: 
        .byte 9, 8, 7
        .byte 6, 5, 4
        .byte 3, 2, 1

        .org $4000
result: .byte 0, 0, 0

        .end
