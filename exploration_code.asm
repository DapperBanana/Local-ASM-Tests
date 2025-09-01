
        .segment "TEXT"

message .asciiz "Hello, World!"

        .segment "DATA"

buffer  .ds.b   256

        .segment "CODE"

reverseString:
        lda     #0              ; Clear zero page counter
        sta     $fb
        ldx     #0              ; Start at beginning of buffer

        lda     message, x      ; Load character from input string
        beq     endReverse      ; If null terminator, jump to end

        inx                     ; Increment buffer index
        jmp     reverseString

endReverse:
        dex                     ; Move back to last valid character

reverseLoop:
        lda     buffer, x       ; Load character from buffer
        sta     $fc             ; Store in temporary register

        lda     message, y      ; Load character from input string
        sta     buffer, x       ; Store in buffer

        lda     $fc             ; Load character from temporary register
        sta     message, y      ; Store in input string

        inx
        dey
        bne     reverseLoop

        rts
