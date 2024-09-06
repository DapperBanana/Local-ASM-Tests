
        .org $2000

start   lda strLength        ; load string length
        tax                  ; store length in X register
        ldx strLength        ; load string length into X register
        
        lda #0               ; load accumulator with 0
        sta destStringIndex  ; set destination string index to 0
        
loop    lda sourceString, x  ; load a character from source string
        sta destString, x    ; store the character in destination string
        dex                  ; decrement the X register
        inc destStringIndex  ; increment the destination string index
        cpx #0               ; check if end of string reached
        bne loop             ; if not, continue looping

done    brk

sourceString .asciiz "Hello, world!"
destString   .ds 14           ; reserve space for reversed string
strLength    .byte 13         ; length of source string
destStringIndex .byte 0       ; index for destination string

        .end
