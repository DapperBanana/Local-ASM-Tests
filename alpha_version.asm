
        .org $0600

start   lda #0             ; Start by initializing index register
        sta $00

loop    lda message,x      ; Load character from original string
        beq end            ; If character is end of string, then go to end
        sta $0200,x        ; Store character in reversed string

        inx                ; Increment index to move to next character
        bne loop           ; Repeat loop until end of string is reached
        bra end

end     lda #0             ; Null terminate the reversed string
        sta $0200,x

        ldx #$FF           ; Set X register to end of reversed string
print   lda $0200,x        ; Load character from reversed string
        beq done           ; If end of string is reached, then exit
        jsr $FFD2          ; Output character to screen
        dex                ; Decrement index to move to previous character
        bra print          ; Repeat until all characters have been output

done    rts

message .asciiz "Hello, world!"

        .end
