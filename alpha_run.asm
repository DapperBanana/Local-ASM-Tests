
        .org $0200

start   lda #num           ; load the number to be factorized
        sta number

        lda #2              ; start checking factors from 2
        sta factor

loop    lda factor         ; check if factor is greater than the number
        cmp number
        bcc done

        lda number         ; divide number by factor
        clc
        lda div

        lda #0             ; initialize the flag is_factor
        sta is_factor

check   lda number        ; check if factor is a prime factor
        clc
        lsr                ; divide by 2
        lda quotient
        sta number

        sec
        lda factor
        sbc quotient
        bcs check_next

        lda #1            ; set is_factor flag if factor is a prime factor
        sta is_factor

check_next
        lda number        ; check next factor
        ldc num

        adc #1            ; increment factor
        sta factor

        lda is_factor     ; check if factor is a prime factor
        beq loop

done    ...

num     .byte $07       ; number to be factorized
factor  .byte $00       ; current factor being checked
is_factor .byte $00     ; flag to indicate if current factor is a prime factor
quotient .byte $00     ; temporary storage for division quotient
