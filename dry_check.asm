
        .org $2000
start:
        lda #$00         ; initialize index
        sta index

find_word:
        lda text, x      ; load character from text
        cmp #$00         ; check for end of file
        beq done

        cmp $word, x     ; check for match with word to find
        bne continue

        lda #$00         ; initialize replacement word index
        sta rep_index

replace_word:
        lda $replace_word, x   ; load character from replacement word
        sta text, x            ; replace character in text
        inx                    ; increment index
        lda $replace_word+1, x ; load next character from replacement word
        sta text, x            ; replace next character in text
        inx                    ; increment index
        lda index              ; load index
        clc
        asl
        tax                    ; double index
        lda $word_end, x       ; load end of word marker
        tax
        ldx index              ; restore index

continue:
        inx                    ; increment index
        jmp find_word

done:
        rts

index:  .byte $00
word:   .byte "old"     ; word to find
word_end: .byte $00
replace_word:   .byte "new"   ; word to replace

text:                          ; text file data
        .byte "hello world old hello old world", $00
