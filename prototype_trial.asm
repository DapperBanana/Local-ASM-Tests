
        .text

start:
        lda #10        ; Input the side length of the hexagon (e.g. 10)
        sta side

        jsr calc_area  ; Call the subroutine to calculate the area

        lda area_high  ; Load the high byte of the area
        sta $0200      ; Store it in memory location $0200
        lda area_low   ; Load the low byte of the area
        sta $0201      ; Store it in memory location $0201

end:
        rts           ; Return from subroutine

calc_area:
        lda side           ; Load the side length
        asl                ; Square the side length
        sta temp

        lda temp           ; Multiply side^2 by 3
        clc
        adc temp
        adc temp
        sta temp

        lda #3
        clc
        jsr multiply       ; Multiply by 3

        lda temp           ; Multiply by sqrt(3)
        clc
        jsr sqrt3
        sta temp

        lda temp           ; Divide by 2
        lsr
        sta temp

        ldx #0             ; Clear the accumulator
        stx area_low
        sty area_high

        lda temp           ; Load the result into the accumulator
        sta area_low
        rts

multiply:
        sec
        lda temp          ; Multiply Accumulator value by Y
        mul y
        sta temp
        rts

sqrt3:
        ldx #0
        lda #5
        sta factor
sqrt3_loop:
        lda temp
        clc
        jsr divide
        lda temp
        clc
        jsr divide
        clc
        lda temp
        adc factor
        lsr
        sta factor
        dec x
        bne sqrt3_loop
        lda factor
        lsr
        lsr
        rts

divide:
        ldx #0
divide_loop:
        cmp #0
        bcc divide_done
        clc
        lda temp
        sbc factor
        inx
        bcc divide_loop
divide_done:
        dec x
        rol factor
        rts

        .data

side:
        .byte 0
factor:
        .byte 0
        .byte 0
temp:
        .byte 0
area_low:
        .byte 0
area_high:
        .byte 0
