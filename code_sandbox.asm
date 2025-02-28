
        .org $1000
START:  lda #0               ; Initialize accumulator to 0
        sta sum              ; Store the sum of areas in memory
        lda #0               ; Initialize loop counter to 0
        sta count            ; Store the loop counter in memory

LOOP:   lda count            ; Load the loop counter
        cmp #5               ; Compare with 5 (pentagon has 5 sides)
        beq DONE             ; If loop counter is 5, exit loop

        lda side_lengths, x  ; Load side length of the pentagon from memory
        sta current_side     ; Store current side length in memory

        lda current_side
        clc
        adc sum              ; Add current side area to sum
        sta sum              ; Store the updated sum in memory

        inx                  ; Increment index to get next side length
        lda count            ; Load the loop counter
        clc
        adc #1               ; Increment loop counter
        sta count            ; Store the updated loop counter

        jmp LOOP             ; Repeat the loop

DONE:   hlt                  ; Halt the program

sum:    .byte 0              ; Memory location to store the sum of areas
count:  .byte 0              ; Memory location to store the loop counter
sides_length:  .byte 10, 10, 10, 10, 10  ; Side lengths of the pentagon

current_side: .byte 0         ; Memory location to store the current side length

        .org $2000
        .word START
