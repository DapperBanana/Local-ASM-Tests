
        .org $0600

number  .byte $00   ; input number to check if it's a perfect square
result  .byte $00   ; result of the perfect square check

start   lda number   ; load the input number into the accumulator
        jsr sqrt     ; call the sqrt subroutine
        sta result   ; store the result in the result variable

        lda result
        cmp result    ; compare the result to the original number
        beq isPerfectSquare   ; if they are equal, it's a perfect square
        bne notPerfectSquare  ; otherwise, it's not a perfect square

isPerfectSquare
        lda #$01     ; load 1 into the accumulator to indicate it's a perfect square
        rts          ; return from the subroutine

notPerfectSquare
        lda #$00     ; load 0 into the accumulator to indicate it's not a perfect square
        rts          ; return from the subroutine

sqrt    ldx #0       ; clear the X register
        ldy #1       ; start with y = 1

loop    lda number   ; get the input number
        cmpa y       ; compare it to y
        beq found    ; if they are equal, we found the sqrt

        cpy number   ; if y > number, break out of the loop
        bcc notFound

        inx          ; increment x
        iny          ; increment y
        jmp loop

found   rts

notFound
        lda x        ; load the result into the accumulator
        rts
