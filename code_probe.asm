
        .text

start:
        lda #48         ; Load first number into accumulator
        sta num1

        lda #36         ; Load second number into accumulator
        sta num2

loop:
        cmp num2        ; Compare num1 and num2
        beq done        ; If they are equal, jump to done

        bcc swap        ; If num1 is less than num2, jump to swap
        lda num1        ; Load num1 into accumulator
        sec             ; Set carry flag
        sbc num2        ; Subtract num2 from accumulator
        sta num1        ; Store result back in num1
        bcc loop        ; If result is positive, jump back to loop

swap:
        lda num1        ; Load num1 into accumulator
        ldx num2        ; Load num2 into index register
        sta temp        ; Store num1 in temp
        sty num1        ; Store num2 in num1
        lda temp        ; Load temp into accumulator
        stx num2        ; Store temp in num2
        bcc loop        ; Jump back to loop

done:
        ; The greatest common divisor is in num1 now
        ; Add your code here to use the GCD value as needed

        ; End program
        brk

        .data

num1:   .byte 0         ; Define storage for first number
num2:   .byte 0         ; Define storage for second number
temp:   .byte 0         ; Define temporary storage
