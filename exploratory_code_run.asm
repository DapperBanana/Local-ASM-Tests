
        .segment "CODE"
START:  lda #0            ; Load accumulator with 0
        sta perfectSquare ; Store 0 in perfectSquare variable
        lda number        ; Load the number to be checked
        ldx #1            ; Load X register with 1
LOOP:   dex               ; Decrement X register
        beq DONE          ; Branch to DONE if X register is 0
        clc               ; Clear carry flag
        lda perfectSquare ; Load perfectSquare variable
        adc x             ; Add X register to accumulator
        sta perfectSquare ; Store the result in perfectSquare variable
        lda perfectSquare ; Load perfectSquare variable
        cmp number        ; Compare with the original number
        bcc LOOP          ; Branch back to LOOP if accumulator is less than the number
        bcs NOT_PERFECT   ; Branch to NOT_PERFECT if accumulator is greater than number
        lda #1            ; Load accumulator with 1 (true)
        bra DONE          ; Branch to DONE
NOT_PERFECT:
        lda #0            ; Load accumulator with 0 (false)
DONE:   rts               ; Return from subroutine

        .segment "DATA"
perfectSquare: .byte 0     ; Define perfectSquare variable
number:        .byte 25    ; Define the number to be checked (change this value as needed)
