
        processor 6502
        org $C000

start:
        lda $C100     ; load length of array
        sec
        sbc #1        ; decrement for comparison
        tax           ; store length in X

        ldx #0        ; initialize index for longest subsequence
        ldy #0        ; initialize index for current subsequence length
        lda $C000,X   ; load element from array
        sta current   ; store current element
        lda #0        ; initialize longest subsequence length
        sta longest
        lda #0        ; initialize prev element
        sta prev

loop:
        inx           ; increment index
        lda $C000,X   ; load element from array
        cmp current   ; compare with current element
        bcc end_subseq ; if current element is less, end current subsequence

        lda $C000,X   ; load element from array
        cmp prev      ; compare with previous element
        bcc reset     ; if current element is less than previous, reset subsequence length
        
        lda longest   ; load longest subsequence length
        clc
        adc #1        ; increment current subsequence length
        sta longest   ; store new longest subsequence length

reset:
        sta $C200,Y   ; store element in subsequence array
        iny           ; increment subsequence index
        sta prev      ; store current element as previous

end_subseq:
        dex           ; decrement index
        cpx #0        ; check if end of array
        bne loop      ; if not end, continue loop

        lda longest   ; load longest subsequence length
        sta $C300     ; store longest subsequence length
        rts           ; return

current: .byte 0
longest: .byte 0
prev: .byte 0
