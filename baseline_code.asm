
        .org $0100

start   lda #5          ; load the number whose factorial needs to be calculated
        sta number

        lda #1          ; load the initial value of the factorial
        sta result

loop    lda number      ; load the number to be multiplied
        cmp #0          ; check if the number is zero
        beq done        ; if number is zero, exit the loop

        jsr multiply    ; call the multiply subroutine

        lda number      ; decrement the number
        sec
        sbc #1
        sta number

        jmp loop        ; repeat the loop

done    lda result      ; load the result
        ; perform any necessary operation here
        ; for displaying the result

        rts             ; return to the calling program

multiply
        clc
        lda result      ; load the current factorial value
        adc number      ; add the number to be multiplied
        sta result      ; store the new factorial value

        rts             ; return from the subroutine

number  .byte 0
result  .byte 0

        .end
