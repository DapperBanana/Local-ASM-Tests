
        .org $0200

base    .byte   $05     ; base area of the pyramid
height  .byte   $08     ; height of the pyramid

        lda     base    ; load base area into accumulator
        clc             ; clear carry bit
        adc     height  ; add height to accumulator
        sta     base    ; store the result back in base

        lda     base    ; load base area into accumulator
        asl             ; multiply by 2
        sta     base    ; store the result back in base

        lda     base    ; load base area into accumulator
        lsr             ; divide by 2
        sta     base    ; store the result back in base

        lda     base    ; load base area (now with height added) into accumulator
        pha             ; push accumulator onto stack

        lda     base    ; load base area into accumulator
        lda     base    ; load base area into accumulator
        jsr     multiply ; call multiply subroutine

        pla             ; pop value from stack into accumulator
        jsr     divide   ; call divide subroutine

        lda     #<$FF   ; load low byte of result
        sta     $FF00   ; store low byte at $FF00
        lda     #>$FF   ; load high byte of result
        sta     $FF01   ; store high byte at $FF01

done    jmp     done    ; endless loop

multiply
        clc             ; clear carry bit
        adc     height  ; add height to accumulator
        rts             ; return from subroutine

divide
        sec             ; set carry bit
        sbc     height  ; subtract height from accumulator
        rts             ; return from subroutine
