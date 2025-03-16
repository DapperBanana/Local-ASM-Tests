
        .org $0200

start   lda #36         ; load first number into the accumulator
        sta num1

        lda #24         ; load second number into the accumulator
        sta num2

loop    lda num1        ; load num1 into A
        cmp num2        ; compare num1 with num2
        beq done        ; if they are equal, exit loop

        bcc num2_greater ; if num2 > num1, go to num2 greater
        sec             ; set carry flag
        sbc num2        ; subtract num2 from num1
        sta num1        ; store the result back in num1
        jmp loop        ; jump back to loop

num2_greater
        sec             ; set carry flag
        lda num1        ; load num1 into A
        sbc num1        ; subtract num1 from num2
        sta num2        ; store the result back in num2
        jmp loop        ; jump back to loop

done    lda num1        ; load num1 into A
        jsr print_num   ; call print_num subroutine

        rts             ; return from subroutine

print_num
        tax             ; transfer A to X
        lda $d0         ; load display data register
        sta $00,x       ; store value in display data register
        rts             ; return from subroutine

num1    .byte 0
num2    .byte 0

        .end
