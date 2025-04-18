
        lda #0        ; initialize first term of Fibonacci sequence to 0
        sta $600
        lda #1        ; initialize second term of Fibonacci sequence to 1
        sta $601
        
        ldx #2        ; initialize counter to 2
.loop   lda $600,x    ; load previous term
        clc
        adc $601,x    ; add previous two terms
        sta $602,x    ; store current term
        
        inx           ; increment counter
        cmp x         ; compare counter to number of terms
        bne .loop     ; loop if counter is not equal to number of terms
        
        rts
