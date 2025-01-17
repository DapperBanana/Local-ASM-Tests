
    LDA #11       ; Load the number of sides (hendecagon) into the accumulator
    STA sides
    
    LDA #360      ; Load the total degrees in a circle into the accumulator
    STA total_degrees
    
    LDA total_degrees
    STA degree_sum
    
start:
    LDA #360      ; Load the number of degrees in each vertex of a regular hendecagon
    STA vertex_degrees
    
    LDA #2        ; Load the number of sides in each side of a regular hendecagon
    STA sides_in_side
    
    LDA vertex_degrees
    STA degree_sum
    
    LDA degree_sum
    ADC degree_sum  ; Multiply the number of vertices with the number of degrees in each vertex
    STA degree_sum
    
    LDA sides
    STA count

loop:
    LDA degree_sum
    ADC vertex_degrees  ; Add the angle at each vertex to the total degree sum
    STA degree_sum

    DEC count
    BNE loop

    LDA degree_sum
    STA total_degrees

    LDA #180       ; Load the degrees in a straight line into the accumulator
    STA straight_degrees

    LDA total_degrees
    STA sum_angle_degrees

    LDA #2
    STA divide

    LDA sum_angle_degrees
    SEC
    SBC straight_degrees  ; Subtract the total angle of the hendecagon from the straight angle degrees
    STA sum_angle_degrees

    LDA sum_angle_degrees
    LSR                  ; Divide the remaining angle by 2 to get the angle at each vertex
    STA hendecagon_angle

    LDA hendecagon_angle
    STA angle

    LDA #10
    STA sides_minus_one

    LDA angle
    SEC
    SBC vertex_degrees
    STA angle

    LDA angle
    ASL
    STA angle

    LDA angle
    JSR cos_table     ; Call subroutine to calculate the cosine of the angle
    STA side_length

    LDX #0
    LDA #0
    STA area

calc_area:
    LDA side_length
    STA side_one

    LDA side_length
    ASL
    STA side_two

    LDA side_length
    ASL
    STA side_three

    LDA side_one
    CLC
    ADC side_two
    ADC side_three
    STA perimeter
    
    LDA side_length
    SEC
    SBC side_one
    STA side_length

    LDA side_length
    ASL
    STA side_length

    LDA side_length
    JSR cos_table
    STA cos_angle

    LDA side_one
    SEC
    SBC cos_angle
    STA side_one

    LDA side_two
    SEC
    SBC cos_angle
    STA side_two

    LDA side_three
    SEC
    SBC cos_angle
    STA side_three

    LDA side_length
    CLC
    ADC side_one
    ADC side_two
    ADC side_three
    STA temp

    LDA temp
    CLC
    ADC perimeter
    STA perimeter

    LDA side_one
    CLC
    ADC side_two
    ADC side_three
    STA temp

    LDA temp
    STA area

    LDA sides_minus_one
    SEC
    SBC #1
    STA sides_minus_one

    LDA sides_minus_one
    BNE calc_area

done:
    BRK

cos_table:
    LDA #0
    STA y
    LDA angle
    CLC
    ADC #0
    STA x
    LDA cos_table,x
    RTS

cos_table:
    .BYTE $100, $F3, $E6, $DA, $CE, $C3, $B9, $B0, $A7, $9F, $97

sides      .BYTE 0
total_degrees   .BYTE 0
degree_sum      .BYTE 0
vertex_degrees  .BYTE 0
sides_in_side   .BYTE 0
count           .BYTE 0
straight_degrees  .BYTE 0
sum_angle_degrees  .BYTE 0
divide          .BYTE 0
hendecagon_angle  .BYTE 0
angle           .BYTE 0
sides_minus_one  .BYTE 0
cos_table       .BYTE 0
y               .BYTE 0
x               .BYTE 0
area            .BYTE 0
temp            .BYTE 0
perimeter       .BYTE 0
cos_angle       .BYTE 0
side_length     .BYTE 0
side_one        .BYTE 0
side_two        .BYTE 0
side_three      .BYTE 0
