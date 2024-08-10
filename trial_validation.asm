
; Program to calculate the area of a rectangle given its length and width
        .org $0200

        LDA #10          ; Load length of rectangle
        STA LENGTH       ; Store in memory location LENGTH

        LDA #5           ; Load width of rectangle
        STA WIDTH        ; Store in memory location WIDTH

        LDA LENGTH       ; Load length into accumulator
        CLC              ; Clear carry flag
        ADC WIDTH        ; Add width to accumulator
        STA AREA         ; Store result in memory location AREA

        BRK              ; End program

LENGTH  .BYTE $00        ; Memory location for length
WIDTH   .BYTE $00        ; Memory location for width
AREA    .BYTE $00        ; Memory location for area

        .end
