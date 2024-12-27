
        .org $0200

str1    .asciiz "kitten"
str2    .asciiz "sitting"

        ldx #0                  ; Initialize X register
        ldy #0                  ; Initialize Y register
        lda str1,x              ; Load character from str1
loop1   cmp #0                  ; Check if end of string
        beq done                ; Exit loop if end of string
        sta current_char        ; Store current character
        lda str2,y              ; Load character from str2
loop2   cmp #0                  ; Check if end of string
        beq done                ; Exit loop if end of string
        sta temp_char           ; Store temp character
        cmp current_char        ; Compare characters
        beq continue            ; Characters match, continue loop
        inc distance            ; Characters differ, increment edit distance
        lda temp_char           ; Load temp character
        cmp current_char
continue
        inx                     ; Increment X register
        iny                     ; Increment Y register
        lda str1,x              ; Load next character from str1
        jmp loop1               ; Repeat loop

done    rts

current_char .byte 0
temp_char    .byte 0
distance     .byte 0

        .end
