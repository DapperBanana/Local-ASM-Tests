
        .org $0200      ; start execution at address 0200
        
start   lda #$00        ; initialize word count to 0
        sta wordCount
        
loop    lda $C000,x     ; load character from text file
        beq endOfFile   ; if end of file (null character), exit loop
        cmp #$20        ; compare character to space
        beq checkNext   ; if space, check for next character
        inx             ; increment index
        bne loop        ; loop back to load next character

checkNext
        lda $C000,x     ; load next character
        beq endOfFile   ; if end of file, exit loop
        cmp #$20        ; compare character to space
        bne checkNext   ; if not space, continue checking next character
        inc wordCount   ; increment word count
        inx             ; move to next character
        bne loop        ; loop back to load next character

endOfFile
        rts             ; return from subroutine

wordCount .byte $00     ; variable to store word count

        .org $BF00      ; address where text file is stored
        .incbin "text.txt"   ; include text file in program
