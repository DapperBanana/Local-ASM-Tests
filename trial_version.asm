
; Reverse the order of words in a sentence

        .text
        .globl _start

_start: lda sentence  ; load the address of the sentence
        ldx #0         ; initialize index
        stx word_start ; set the start of the first word
        
next_word: 
        lda sentence, x   ; load the next character
        beq end_of_sentence ; check if end of sentence
        cmp #32           ; check for space character
        bne not_space
        
        lda x           ; load index of word_start
        jsr reverse_word  ; reverse the word
        lda #32         ; load space character
        sta sentence, x ; replace space with reversed word
        inx             ; move to next character
        
not_space: 
        inx            ; move to next character
        bne next_word  ; loop back
        
end_of_sentence:
        lda word_start       ; load index of last word start
        jsr reverse_word     ; reverse the last word
        
exit:
        lda #10              ; load newline character
        jsr putc            ; print a newline
        lda sentence         ; load address of the sentence
        jsr puts            ; print the modified sentence
        lda exit_code       ; load exit code
        jsr exit_program    ; exit the program

reverse_word:
        lda word_start        ; load index of word start
        sta word_end          ; set as end of the word
        
        ldx #0               ; initialize index
        
reverse_loop:
        lda sentence, x      ; load character from start
        cmp word_end          ; check for end of word
        beq reverse_end       ; if end of word, done
        
        inx                  ; increment index to move forward
        
        ldy sentence, x      ; load character from end
        sta temp             ; store temporarily
        dey                  ; decrement index
        sty sentence, x      ; store character from end to start
        lda temp             ; load temporarily stored character
        sta sentence, y      ; store character from start to end
        
        bne reverse_loop     ; loop back
        
reverse_end:
        rts

     .data
sentence: .asciiz "Hello World Assembly Program"
word_start: .byte 0
word_end: .byte 0
temp: .byte 0
exit_code: .byte 0
     
;)os n jasldkj%
