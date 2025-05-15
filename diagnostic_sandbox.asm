
* = $0600

movie_titles
    .asciiz "1. The Shawshank Redemption\n"
    .asciiz "2. The Godfather\n"
    .asciiz "3. The Dark Knight\n"

recommendation_msg
    .asciiz "Enter the number of the movie you would like a recommendation for (1-3): \n"

good_msg
    .asciiz "You should watch "

bad_msg
    .asciiz "Sorry, that is not a valid choice. Please try again.\n"

* = $8000

start
    lda #$00
    sta $fb
    lda #$00
    sta $fc
    
    jsr print_recommendation_msg
    jsr get_user_input
    
    lda $fb
    cmp #$31
    bne invalid_input
    
    lda $fc
    cmp #$01
    bne invalid_input
    
    lda #$FF
    sta $fe
    
    ldx #$02
    jsr print_good_msg
    lda $fc
    jsr print_movie_title
    jmp end
    
invalid_input
    ldx #$01
    jsr print_bad_msg
    jmp start
    
print_recommendation_msg
    ldx #$00
loop1
    lda recommendation_msg,x
    beq endloop1
    jsr $ffd2
    inx
    jmp loop1
endloop1
    rts
    
print_good_msg
    lda #$00
    jsr $ffd2
    ldx #$00
loop2
    lda good_msg,x
    beq endloop2
    jsr $ffd2
    inx
    jmp loop2
endloop2
    rts
    
print_bad_msg
    lda #$00
    jsr $ffd2
    ldx #$00
loop3
    lda bad_msg,x
    beq endloop3
    jsr $ffd2
    inx
    jmp loop3
endloop3
    rts

print_movie_title
    ldx $fc
    lda movie_titles,x
    jsr $ffd2
    rts

get_user_input
    jsr $ffcf
    sta $fb
    lda $fb
    cmp #$31
    bcc end_input
    lda $fb
    cmp #$33
    bcs end_input
    lda $fb
    sbc #$30
    sta $fc
end_input
    rts
    
end
    jmp end
