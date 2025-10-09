
        lda #6            ; load the number of sides of the hexagon
        sta sides

        lda #10           ; load the length of each side of the hexagon
        sta side_length

        clc               ; clear the carry flag
        lda sides         ; load the number of sides into the accumulator
        adc sides         ; add the number of sides to the accumulator
        adc sides         ; add the number of sides to the accumulator
        asl               ; multiply the accumulator by 2 (shift left)
        tax               ; transfer the result to the X register

        lda side_length   ; load the length of each side into the accumulator
        asl               ; multiply the side length by 2 (shift left)
        tay               ; transfer the result to the Y register

        lda x             ; load the result of (6 + 6) * 2 into the accumulator
        sta temp
        lda y             ; load the result of 10 * 2 into the accumulator
        adc temp          ; add (6 + 6) * 2 to the accumulator
        lsr               ; divide the result by 2 (shift right)
        sta perimeter     ; store the perimeter of the hexagon

        lda perimeter     ; load the perimeter of the hexagon into the accumulator
        ldx sides         ; load the number of sides into the X register
        jsr divide        ; call the divide subroutine to divide the perimeter by the number of sides

        lda quotient      ; load the result of the division into the accumulator
        pha               ; push it onto the stack

        lda y             ; load the result of 10 * 2 into the accumulator
        sta temp
        lda quotient      ; load the result of the division into the accumulator
        adc temp          ; add 10 * 2 to the accumulator
        lsr               ; divide the result by 2 (shift right)
        sta area          ; store the area of the hexagon

done:
        lda area          ; load the area of the hexagon into the accumulator
        rts               ; return from subroutine

divide:
        sec               ; set the carry flag
loop:
        sbc x             ; subtract the number of sides from the accumulator
        bcc done_divide   ; branch if carry clear (result is negative)
        inc quotient      ; increment the quotient
        jmp loop          ; loop until result is negative
done_divide:
        rts               ; return from subroutine

sides    .byte 0
side_length .byte 0
perimeter .byte 0
temp     .byte 0
area     .byte 0
quotient .byte 0
