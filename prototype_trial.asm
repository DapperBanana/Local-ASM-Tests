
; Checks if a given year is a palindrome year
; Input: Year stored in memory location $1000-$1001
; Output: Result (1 if palindrome year, 0 if not) stored in memory location $1002

    processor 6502
    org $1000

year        .byte $00, $00
result      .byte $00

start       lda year
            ldx year+1
            cmp year+1
            bne not_palindrome
            lda #$01
            sta result
            rts

not_palindrome
            lda #$00
            sta result
            rts
