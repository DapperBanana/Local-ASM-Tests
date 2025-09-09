
    .org $0600

start:
    lda #$00        ; Accumulator to store sum
    ldx #$00        ; X register to keep track of number of elements
    ldy #$0100      ; Y register to point to the start of the list

loop:
    lda (y),y       ; Load the next element into the accumulator
    clc             ; Clear the carry flag
    adc $00         ; Add the element to the sum
    sta $00         ; Store the updated sum

    inx             ; Increment the number of elements
    cpx #$0A        ; Compare with 10
    bne next        ; If not all elements processed, continue

    lda $00         ; Load the sum back into the accumulator
    sec             ; Set the carry flag
    ldx #$0A        ; Load the divisor (number of elements) into X
    div $00         ; Divide the sum by the number of elements
    sta $00         ; Store the average in memory

next:
    iny             ; Move to the next element
    cpy #$010A      ; Compare with the end of the list
    bne loop        ; If not at the end, repeat loop

    brk             ; Break and end program

    .org $FFFA
    .word start
