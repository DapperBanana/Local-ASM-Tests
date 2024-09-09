
        .org $0200

        LDA #20        ; Number of faces in an icosahedron
        STA $00

        LDA #5         ; Number of vertices in an icosahedron
        STA $01

        LDA #3         ; Number of edges in an icosahedron
        STA $02

        LDA $00        ; Load number of faces into accumulator
        CLC            ; Clear carry for addition
        ADC $01        ; Add number of vertices
        STA $03        ; Store result in memory

        LDA $03        ; Load result of addition
        STA $04

        ASL            ; Multiply by 2 to get total number of vertices * 2
        STA $03

        LDA $00        ; Load number of faces again
        CLC
        ADC $02        ; Add number of edges
        STA $05        ; Store result in memory

        LDA $05        ; Load result of addition
        STA $06

        ASL            ; Multiply by 2 to get total number of edges * 2
        STA $05

        LDX $03        ; Load number of vertices * 2 into X register
        LDA $05        ; Load number of edges * 2 into accumulator
        CLC
        ADC $06        ; Add number of edges * 2 to accumulator
        STA $07        ; Store result in memory

        LDA $07        ; Load result of addition
        STA $08

        LDX $07        ; Load final result into X register
        STX $0200      ; Store final result in memory

        BRK            ; End program

        .end
