
; Calculate the area of a parallelogram
; Formula: Area = base * height

    .org $0200

start
    LDX #base
    LDY #height

    LDA #0
    STA area

calculate_area
    CLC
    LDA base
    ADC area
    STA area
    DEY
    BNE calculate_area

    ; Display the result
    LDX area
    JSR output_x ; Print the area
    BRK

base    .byte $05
height  .byte $0A
area    .byte $00

    .org $FE00
output_x
    STA $FE04
    LDA $FE00
    CMP #$30
    BEQ done
    JSR $FFD2
    JMP output_x
done
    RTS
