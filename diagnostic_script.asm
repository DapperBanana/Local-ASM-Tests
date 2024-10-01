
        .org $0200

start   lda number      ; load the number into the accumulator
        tay             ; copy it into Y register

sumLoop clc             ; clear carry flag
        lsr             ; shift right the number
        bcc sumEnd      ; if carry flag is clear, skip add
        adc #0          ; add the value in the accumulator to 0
sumEnd  bcc sumLoop     ; branch if carry clear

        sta result      ; store the result in memory

done    lda number      ; load the number back into the accumulator
        cmp #10         ; compare with 10
        bcs start       ; branch if number is greater than or equal to 10
        jmp done        ; otherwise, keep looping

number  .byte $0A       ; initial number to calculate
result  .byte $00       ; result storage

        .end
