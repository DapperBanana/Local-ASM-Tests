
        .org $0200

data    .byte $07, $0A, $0D, $0B, $06, $02, $08, $0C, $09

        LDX #0              ; Initialize X index
loop    LDA data, X        ; Load data point
        STA $D020           ; Set plotter cursor
        LDA $D021           ; Get Y position
        STA $D022           ; Set plotter Y position
        INX                 ; Increment X index
        CPX #9              ; Check if end of data
        BNE loop            ; If not, continue looping
done    BRK                 ; End program
