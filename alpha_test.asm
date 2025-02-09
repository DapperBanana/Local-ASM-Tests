
; 6502 Assembly program to count the number of vowels in a given string

    .org $6000  ; start address of the program

start:
    lda #$00    ; initialize the count of vowels
    sta count

    ldx #$00    ; initialize the index of the string
    ldy #$00    ; initialize the count of vowels

loop:
    lda string, x  ; load the current character of the string
    beq end        ; if null character, end the program

    cmp #65        ; compare with 'A'
    bcc next       ; if less than 'A', not a vowel
    cmp #90        ; compare with 'Z'
    bcs next       ; if greater than 'Z', not a vowel

    cmp #65        ; compare with 'A'
    bcc check_lower_case  ; if less than 'A', check if lower case

    jmp is_vowel  ; jump to is_vowel

check_lower_case:
    cmp #97        ; compare with 'a'
    bcc next       ; if less than 'a', not a vowel
    cmp #122       ; compare with 'z'
    bcs next       ; if greater than 'z', not a vowel
    
is_vowel:
    iny            ; increment the count of vowels

next:
    inx            ; move to the next character of the string
    jmp loop       ; continue looping

end:
    sta count     ; store the count of vowels
    
    ; end of program

string:
    .asciiz "Hello, world!"  ; example string

count:
    .byte $00                ; variable to store the count of vowels

    ; end of program
