
        .org $1000

start   lda #0          ; Initialize sum to 0
        sta sum

        ldx #0          ; Initialize index to 0

loop    lda list,x     ; Load the current element into the accumulator
        clc            ; Clear the carry flag
        adc sum        ; Add the current element to the sum
        sta sum        ; Store the new sum
        inx            ; Increment index
        cpx #<list_end ; Check if end of list is reached
        bne loop       ; Loop back if not reached

done    lda sum        ; Load the sum into the accumulator
        ; Store or use the sum as needed
        ; (e.g., store it in memory location, print it, etc.)

        rts            ; Return from the program

list    .byte $01, $02, $03, $04, $05  ; List of elements
list_end

sum     .byte 0        ; Variable to store the sum

        .end
