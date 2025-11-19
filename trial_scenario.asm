
        .text
        .org $c000

        lda #$00               ; Initialize counter
        sta counter
        lda #$11               ; Load the length of the string being checked
        sta string_length

loop:
        ldx counter            ; Load counter into X register
        lda input_string,x     ; Load character from input string
        ldy #$30               ; Load '0' into Y register

        cmp #$20               ; Check if end of string
        beq end

        cmp y                  ; Check if character is between '0' and '9'
        bcc invalid

        lda #$39               ; Load '9' into A register
        cmp y                  ; Check if character is between '0' and '9'
        bcs invalid

        inc counter            ; Increment counter
        bne loop

invalid:
        lda #$00               ; Set invalid flag
end:
        rts

        .data
input_string:
        .byte $31,$30,$38,$37,$46,$66,$35,$36,$33,$00
counter:
        .byte $00
string_length:
        .byte $00
