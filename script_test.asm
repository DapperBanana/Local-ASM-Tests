
        .org $0200

list    .byte $02, $05, $07, $0A, $0D, $0F, $12, $15, $18, $1B
result  .byte 10 dup(0)

start   ldx #0              ; Initialize index register
loop    lda list,x          ; Load the current element from the list into the accumulator
        sta $00             ; Store the current element into a temporary memory location
        asl                 ; Multiply the accumulator by itself to calculate the square
        sta result,x        ; Store the square into the result array
        lda $00             ; Reload the current element from the temporary memory location
        sta result+1,x      ; Store the original element into the result array
        inx                 ; Increment index
        cpx #10             ; Check if all elements have been processed
        bne loop            ; If not, continue looping

done    brk                 ; Break and end program

        .end
