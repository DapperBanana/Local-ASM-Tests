
        .org $0400

start   lda #0                 ; Initialize accumulator to 0
        sta sum                ; Store initial sum in memory
        lda #10                ; We are going to calculate the sum of the first 10 natural numbers
        sta n                  ; Store n in memory

loop    lda sum                ; Load the current sum
        clc                    ; Clear carry
        adc n                  ; Add n to the sum
        sta sum                ; Store the new sum
        dec n                  ; Decrement n
        bne loop               ; Continue loop until n is 0

        lda sum                ; Load the final sum
        jsr print_sum          ; Call subroutine to print the sum

done    jmp done               ; End program

sum     .byte 0

n       .byte 0

print_sum:
        sta $D020              ; Write character to screen
        sta $D020              ; Write character to screen
        lda #13                ; Load carriage return
        sta $D020              ; Write carriage return
        lda #10                ; Load line feed
        sta $D020              ; Write line feed
        rts

        .end
