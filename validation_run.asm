
        .text
start:
        lda str1           ; Load address of first string into A
        sta ptr1

        lda #$00           ; Initialize counter
        sta count

loop:
        lda (ptr1),y       ; Load character from first string
        sta temp1

        lda str2           ; Load address of second string into A
        sta ptr2

        lda (ptr2),y       ; Load character from second string
        sta temp2

        cmp temp1,temp2    ; Compare characters

        beq equal          ; Branch if characters are equal
        inc count          ; Increment counter

equal:
        iny                ; Increment index
        cpy #$08           ; Check if end of strings
        bne loop

        ldx count          ; Load count into X
        jsr print          ; Call print subroutine

        rts

print:
        lda #"The Hamming distance is: "
        jsr print_string

        lda count
        jsr print_number

        rts

print_string:
        ldy #$00

string_loop:
        lda (ptr1),y
        beq string_end

        jsr print_char

        iny
        bne string_loop

string_end:
        rts

print_char:
        jsr $ffd2  ; Output character
        rts

print_number:
        jsr $ffd2  ; Output digit
        rts

count:  .byte $00
ptr1:   .word $0000
ptr2:   .word $0000
temp1:  .byte $00
temp2:  .byte $00
str1:   .asciiz "STRING1"
str2:   .asciiz "STRING2"
