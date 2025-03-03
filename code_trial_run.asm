
    LDX #11       ; initialize X register with number of sides (11)
    LDA #180      ; load 180 into accumulator (exterior angle of a regular hendecagon)
    STA angle     ; store angle in memory location angle

    LDA radius    ; load radius of the hendecagon into accumulator
    LDX #0        ; initialize X register for loop counter
    LDA #0        ; clear accumulator to store sum of areas
loop:
    ASL           ; multiply the radius by 2
    ADC radius    ; add the radius to the result (2 * radius)
    STA side_len  ; store the side length in memory location side_len
    JSR calc_area ; call subroutine to calculate the area of a triangle
    INX           ; increment loop counter
    CPX #11       ; compare loop counter with number of sides
    BNE loop      ; branch back to loop label if loop counter is not equal to 11

    ; final area is stored in accumulator

calc_area:
    LDA angle     ; load angle into accumulator
    CLC           ; clear carry flag
    ADC angle     ; add angle to accumulator
    ADC angle     ; add angle to accumulator
    STA total     ; store total angle in memory
    LDA total     ; load total angle into accumulator
    LSR           ; divide total angle by 2
    STA total     ; store half angle in memory
    LDA side_len  ; load side length into accumulator
    STA base      ; store base in memory location base
    LDA base      ; load base into accumulator
    LSR           ; divide base by 2
    STA base      ; store half base in memory
    LDA base      ; load base into accumulator
    STA height    ; store height in memory location height
    LDA height    ; load height into accumulator
    TAY           ; transfer height to Y register
    LDA total     ; load total angle into accumulator
    PHA           ; push total angle onto stack
    LDA #0        ; clear accumulator
    PHA           ; push 0 onto stack
    JSR calculate ; call subroutine to calculate area of triangle
    PLA           ; pull total angle from stack
    PLX           ; pull triangle area from stack to accumulator
    CLC           ; clear carry flag
    ADC total     ; add total angle to accumulator
    ORA $01       ; OR with area accumulation
    STA total     ; store total area in memory
    RTS           ; return from subroutine

calculate:
    LDA base      ; load base into accumulator
    ADC base      ; add base to accumulator
    STA sum       ; store sum in memory location sum
    LDA total     ; load total angle into accumulator
    ADC total     ; add total angle to accumulator
    ADC total     ; add total angle to accumulator again
    STA total     ; store total angle in memory
    LDA sum       ; load sum into accumulator
    EOR $01       ; exclusive OR with area accumulation
    STA sum       ; store area in memory
    RTS           ; return from subroutine

radius: .BYTE 10  ; define radius as 10
angle:  .BYTE 0   ; define angle as 0
total:  .BYTE 0   ; define total as 0
side_len: .BYTE 0 ; define side length as 0
base:   .BYTE 0   ; define base as 0
height: .BYTE 0   ; define height as 0
sum:    .BYTE 0   ; define sum as 0
