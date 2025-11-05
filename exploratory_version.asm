
    .org $0200

start:
    lda #0         ; load accumulator with 0
    sta count      ; store accumulator in count
    ldx #0         ; load index register with 0

loop:
    lda message, x ; load character at current index into accumulator
    cmp #$41       ; compare if character is greater or equal to 'A'
    bcc not_vowel  ; branch if character is not a vowel
    
    cmp #$41       ; compare if character is greater or equal to 'A'
    bcs uppercase  ; branch if character is uppercase
    
    cmp #$61       ; compare if character is greater or equal to 'a'
    bcc not_vowel  ; branch if character is not a vowel
    
uppercase:
    cmp #$5A       ; compare if character is less or equal to 'Z'
    bcs not_vowel  ; branch if character is not a vowel

vowel:
    inx            ; increment index register
    inc count      ; increment count of vowels
    jmp next_char  ; jump to next character

not_vowel:
    inx            ; increment index register

next_char:
    cpx #$0D       ; compare if end of string
    beq done       ; branch if end of string
    jmp loop       ; loop to process next character

done:
    lda count      ; load count of vowels into accumulator
    sta result     ; store count of vowels in result
    rts            ; return from subroutine

message:
    .asciiz "Hello World!"
count:
    .byte 0
result:
    .byte 0

    .end start
