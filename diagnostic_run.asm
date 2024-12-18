
        .org $1000

start   lda #0          ; Initialize sum to 0
        sta sum

        lda number      ; Load the number into the accumulator
loop
        clc
        adc #$30        ; Convert ASCII digit to binary
        and #$0F        ; Mask upper nibble
        clc
        adc sum         ; Add digit to sum
        sta sum

        lsr             ; Shift right to prepare for BCD adjustment
        lsr
        lsr
        lsr

        bcc skip_adjust ; If carry is clear, no need to adjust
        lda sum         ; Add 1 to the sum if BCD adjustment was performed
        clc
        adc #1
        sta sum

skip_adjust
        lda number
        cmp #$39        ; Check if the number is 9
        beq done        ; If so, we are done

        inx             ; Increment the loop counter
        inc number      ; Increment the number
        jmp loop        ; Continue looping

done    lda sum         ; Load the final sum into the accumulator
        jmp $FFFC       ; End program

number  .byte $35       ; Initial number to calculate sum

sum     .byte 0         ; Variable to store the sum

        .end
