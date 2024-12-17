
        .org    $1000
start   lda     #$00        ; initialize sum to 0
        sta     $01         ; store sum at memory location $01
        ldx     $00         ; load n into X register
loop    dex                 ; decrement n
        bpl     calc_sum    ; if n >= 0, calculate sum
        lda     $01         ; load sum from memory
        rts                 ; return from subroutine

calc_sum
        clc
        lda     $01         ; load current sum
        cmp     #$FF        ; check if current sum is max value
        beq     overflow    ; if so, set overflow flag
        adc     x           ; add current value of n to sum
        sta     $01         ; store updated sum
        jmp     loop        ; loop back

overflow
        lda     #$FF
        sta     $01
        jmp     loop

        .org    $FFFA
        .word   start       ; set NMI vector
