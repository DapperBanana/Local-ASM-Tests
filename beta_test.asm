
; Program to check if a given number is a perfect square
; Input: Number to check in X register
; Output: 1 in X register if number is a perfect square, 0 if not

        lda #$00        ; Initialize counter
        sta $01
        lda #$00        ; Initialize accumulator
        sta $02

loop    cmp $02         ; Compare accumulator with input number
        beq perfect     ; Branch to perfect if equal
        bcc not_perfect  ; Branch to not_perfect if accumulator is less than input number

not_perfect
        lda #$00        ; Load 0 into X register
        rts             ; Return from subroutine

perfect
        lda $01         ; Load counter into accumulator
        cmp $02         ; Compare accumulator with input number
        beq is_perfect  ; Branch to is_perfect if equal

        inc $01         ; Increment counter
        clc             ; Clear carry flag
        adc $01         ; Add counter to accumulator
        jmp loop        ; Jump to loop

is_perfect
        lda #$01        ; Load 1 into accumulator
        rts             ; Return from subroutine
