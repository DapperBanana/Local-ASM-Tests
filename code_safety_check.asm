
START   lda #0         ; Initialize index counter
        sta INDEX

LOOP    lda STRING,X   ; Load character from string
        cmp #$30       ; Compare with ASCII '0'
        bcc INVALID    ; Branch if not a number
        
        cmp #$39       ; Compare with ASCII '9'
        bcs INVALID    ; Branch if not a number
        
        inx            ; Increment index
        cpx #16        ; Check if end of string
        beq VALID      ; Branch if end of string
        bne LOOP       ; Otherwise, continue looping

VALID   lda #1         ; Load valid flag
        rts

INVALID lda #0         ; Load invalid flag
        rts

INDEX   .byte 0

STRING  .ascii "1234567890123456"  ; Example credit card number

        .end START
