
        .org $0200
        
        LDX #20        ; Number of faces in an icosahedron
        LDA #5         ; Length of each face side
        STA side
        LDA #sqrt25    ; Square root of 25 (5*5)
        STA root25
        LDA #3         ; Number of faces meeting at each vertex
        STA vertexFaces
        
        LDA side
        LDX #0
calculateArea:
        CLC
        ADC root25
        STA temp
        TXA
        STA sum
        LDA vertexFaces
        CLC
        ADC sum
        STA sum
        DEX
        BNE calculateArea
        
        LDA sum
        JSR printResult
        
        BRK
        
printResult:
        STA $D020      ; Set the X register to the area
        RTS
        
; Constants
        .org $FCFE
sqrt25: .byte $02
vertexFaces: .byte $03
side: .byte $05
