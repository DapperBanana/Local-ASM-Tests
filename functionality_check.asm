
        .org $0200
start   lda #<text      ; Load the low byte of the address of the text buffer
        sta $00         ; Store it in $00
        lda #>text      ; Load the high byte of the address of the text buffer
        sta $01         ; Store it in $01

        ldx #$00        ; Initialize X register to 0 (index for text buffer)
        
loop    lda ($00),x     ; Load a character from the text buffer into accumulator
        cmp #$20        ; Compare the character to a space 
        beq end         ; If it is a space, go to the end of the program
        
        cmp #$23        ; Compare the character to a hashtag (#)
        bne next_char   ; If it is not a hashtag, go to the next character
        
        jsr print       ; Print the hashtag
        jmp next_char   ; Go to the next character
        
next_char
        inx             ; Increment index for text buffer
        cpx #text_end   ; Check if we reached the end of the text
        bne loop        ; If not, go back to the beginning of the loop

end     rts             ; End of the program

print   lda #$FF        ; Print hashtag symbol
        jsr $FFD2       ; Call KERNAL routine to print the character
        rts

text    .text "This is a #sample text with #hashtags and #morehashtags"
text_end

        .end
