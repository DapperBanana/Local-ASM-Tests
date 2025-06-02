
    .segment "CODE"
    .org $1000

start:
    LDX #$0           ; Initialize index variable to 0
    LDA #10           ; Load the number of sides in the decagon
    STA sides

calc_side_length:
    LDA side_length    ; Load the side length of the decagon
    CMP #$0           ; Check if the side length is 0
    BEQ end_program   ; End the program if side length is 0

    LDA #$360         ; Load the total external angle of the decagon (360 degrees)
    SEC
    SBC sides         ; Subtract the number of sides in the decagon
    STA angle

    LDA angle         ; Load the external angle
    LSR               ; Divide the angle by 2
    LSR

    LDX #$0           ; Initialize index variable
calc_cos:
    LDA angle         ; Load the external angle
    CLC
    ADC #$0A          ; Add 10 (cosine of 36 degrees in degrees format)
    STA cos

    LDA angle         ; Load the external angle
    SEC
    SBC cos           ; Subtract the cosine of the angle
    STA angle

    DEX               ; Decrement index
    BNE calc_cos      ; Loop until index becomes 0
    LDA cos           ; Load the final cosine value

    STA result        ; Store the result

end_program:
    BRK

    .segment "DATA"
sides:       .byte 0
side_length: .byte 5
cos:         .byte 0
result:      .byte 0

    .end start
