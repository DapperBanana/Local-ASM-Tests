
        .org $0200

number  .byte $63     ; Change this value to the number you want to check
length  .byte 2       ; Change this value to the number of digits in the number

start   lda number    ; Load the number into the accumulator
        ldx #0        ; Initialize index register to 0
        ldy #0        ; Initialize sum register to 0

loop    clc           ; Clear the carry bit
        lda number    ; Load the number into the accumulator
        dex           ; Decrement index register
        lsr           ; Shift the accumulator right
        lsr           ; Shift the accumulator right
        iny           ; Increment the sum register
        tay           ; Transfer the sum register to Y register
        adc #$30      ; Add ASCII value of '0' to the accumulator
        cmp number,x  ; Compare the accumulator with the original number
        bne not_narcissistic ; Branch if not equal
        cpx length    ; Compare index register with length
        bne loop      ; Branch if not at the end of the number
        lda #1        ; Load 1 into the accumulator (narcissistic number)
        br end        ; Branch to the end of the program

not_narcissistic
        lda #0        ; Load 0 into the accumulator (not a narcissistic number)

end     sta $0201     ; Store the result at memory location $0201

        lda $0201     ; Load the result into the accumulator
        tax           ; Transfer the accumulator to the index register

done    brk           ; End of program

        .org $FFFA
        .word start   ; Set the reset vector to the start of the program
