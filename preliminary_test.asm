
    .org $0200

cube_side    .byte $05      ; side length of the cube

    LDA cube_side
    STA $FB        ; save side length in memory location FB
    LDX #$06       ; X will store the result (6 sides)

    LDA cube_side
    STA $FC        ; save side length in memory location FC

    LDA cube_side
    STA $FD        ; save side length in memory location FD

    LDA cube_side
    STA $FE        ; save side length in memory location FE

    LDA cube_side
    STA $FF        ; save side length in memory location FF

    JSR calc_surface_area

    HLT

calc_surface_area:
    LDA $FB
    CLC
    ADC $FC
    ADC $FD
    ADC $FE
    ADC $FF
    TAX            ; store the result in X register
    RTS
