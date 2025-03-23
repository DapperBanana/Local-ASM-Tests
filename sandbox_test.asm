
        .org $1000

array   .byte $0F, $0B, $0E, $03, $06, $0A, $05, $0C, $07, $00
length  .byte 10
lis_len .byte 0    ; length of longest increasing subsequence
lis_ptr .byte 0    ; pointer to the starting index of LIS

start
        ldx #0       ; initialize index to 0
        lda length   ; load the length of the array
        sta lis_len  ; store the length of LIS
        lda #0        ; initialize LIS pointer
        sta lis_ptr

loop
        lda array, x ; load value at index x
        cmp array, x+1 ; compare with next value
        bcs skip      ; if next value is greater, skip
        inx           ; increment index
        lda lis_len
        inc a         ; increment length of LIS
        sta lis_len
        lda x         ; update LIS pointer
        sta lis_ptr
skip
        inx
        cpx length   ; check if end of array
        bne loop      ; if not, loop back
        rts           ; return from subroutine
