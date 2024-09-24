
        .org $2000

        ; Input data
data_x: .byte 10, 20, 30, 40, 50
data_y: .byte 20, 30, 40, 50, 60
num_points = 5

        ; Calculate sum_x, sum_y, sum_xy, sum_x_squared
        lda #0
        sta sum_x
        sta sum_y
        sta sum_xy
        sta sum_x_squared
        
calculate_sums:
        lda sum_x
        clc
        adc data_x, x
        sta sum_x
        
        lda sum_y
        clc
        adc data_y, x
        sta sum_y
        
        lda sum_xy
        clc
        lda data_x, x
        mul data_y, x
        clc
        adc acc
        sta sum_xy
        
        lda sum_x_squared
        clc
        lda data_x, x
        mul data_x, x
        clc
        adc acc
        sta sum_x_squared
        
        inx
        cpx num_points
        bne calculate_sums
        
        ; Calculate slope and intercept
        lda sum_xy
        sta tmp1
        lda sum_x
        sta tmp2
        ldx num_points
        dex
        lda tmp2
        mul tmp2
        ldx #2
        lsr
        sta tmp3
        lda tmp3
        mul tmp1
        sta tmp4
        lda sum_x_squared
        sta tmp5
        lda tmp5
        mul tmp2
        cmp tmp4
        bcs positive_slope
        sec
        sbc tmp4
        sta divisor
        jmp after_divisor_set

positive_slope:
        lda tmp4
        sbc tmp5
        sta divisor
after_divisor_set:
        lda divisor
        div tmp1
        sta slope
          
        lda sum_y
        sta tmp1
        lda sum_x
        sta tmp2
          
        lda slope
        mul tmp2
        sta tmp3
        lda tmp1
        sec
        sbc tmp3
        sta intercept
      
end:    
        ; End program
        rts

        ; Variables
sum_x:  .word
sum_y:  .word
sum_xy: .word
sum_x_squared: .word
slope:  .word
intercept: .word
divisor: .word
tmp1:   .word
tmp2:   .word
tmp3:   .word
tmp4:   .word
tmp5:   .word

        .end
