
        .org    $0200

num     .byte   $34     ; number to check for perfect square
temp    .word   0       ; temporary variable
result  .byte   0       ; result of the perfect square check

        lda     num     ; load the number to check
        ldy     #$00    ; initialize counter
        ldx     #$01    ; initialize square of counter

check:
        cmp     num     ; compare the current square value with the number
        beq     found   ; if they are equal, the number is a perfect square

        iny             ; increase the counter
        clc
        adc     x       ; add 2 * counter + 1 to the square value
        sta     x       ; update the square value
        bcc     check   ; loop back to compare

not_found:
        lda     #$00    ; if no perfect square found
        sta     result

done:   rts

found:
        lda     #$01    ; if a perfect square found
        sta     result
        rts

        .end
