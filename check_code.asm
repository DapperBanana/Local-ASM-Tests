
        .org $0600

text    .asc "I love programming on the 6502!"
msg_pos .asc "Positive sentiment detected."
msg_neu .asc "Neutral sentiment detected."
msg_neg .asc "Negative sentiment detected."
result  .byte 0

start   lda #<text
        ldy #>text
        jsr nlp
        
        lda result
        cmp #1
        beq positive
        
        lda result
        cmp #0
        beq neutral
        
        lda result
        cmp #$FF
        beq negative
        
positive
        lda #<msg_pos
        ldy #>msg_pos
        jsr print_msg
        jmp end
        
neutral
        lda #<msg_neu
        ldy #>msg_neu
        jsr print_msg
        jmp end
        
negative
        lda #<msg_neg
        ldy #>msg_neg
        jsr print_msg
        jmp end
        
print_msg
        sta $07F8
print
        ldy $07F8
        lda (y),x
        sta $D020
        inx
        cpx #0
        bne print
        rts
        
end     rts
        
nlp     lda #$FF
        sta result
        
loop    lda (y),x
        beq exit
        
        ; Here you can implement your sentiment analysis logic
        ; For simplicity, we're just checking for the word "love"
        cmp #"l"
        bne loop_next
        inx
        lda (y),x
        cmp #"o"
        bne loop_next
        inx
        lda (y),x
        cmp #"v"
        bne loop_next
        inx
        lda (y),x
        cmp #"e"
        bne loop_next
        
        lda #1
        sta result
        
loop_next
        inx
        bne loop
        iny
        jmp loop
        
exit    rts
