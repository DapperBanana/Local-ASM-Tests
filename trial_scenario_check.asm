
        .text
        .org $0200             ; Start address
start:
        ldx #$00               ; Initialize loop counter
        ldy #$05               ; Number of sides in a pentagon

loop:   lda side_values, x      ; Load the value of each side from the array
        clc
        adc area               ; Add the value to the running sum
        sta area
        inx
        dey
        bne loop              ; Loop until all sides have been processed

        lda area               ; Load the result into the accumulator
        sta result             ; Store the result in memory

        ; End program here
done:
        jmp done               ; Infinite loop

        .data

area:   .byte $00               ; Initialize area variable
result: .byte $00               ; Initialize result variable
side_values:
        .byte $03, $04, $05, $04, $03   ; Values of each side of the pentagon

        .end
