
        .org $0200
        
input   .byte   "HELLO, WORLD!", 0  ; Input string
count   .byte   0                   ; Vowel count

start   lda     #0                  ; Initialize vowel count
        sta     count
        
loop    lda     input, x            ; Load character from input string
        cmp     #65                 ; Check if character is A
        beq     is_vowel            ; Branch if equal
        cmp     #69                 ; Check if character is E
        beq     is_vowel            ; Branch if equal
        cmp     #73                 ; Check if character is I
        beq     is_vowel            ; Branch if equal
        cmp     #79                 ; Check if character is O
        beq     is_vowel            ; Branch if equal
        cmp     #85                 ; Check if character is U
        beq     is_vowel            ; Branch if equal
        
        inx                         ; Increment index
        cpx     #20                 ; Check if end of string
        bne     loop                ; Loop if not at end
        
done    lda     count               ; Load vowel count into register A
        ; output stored in register A
        
end     brk                         ; End program
        
is_vowel
        inc     count               ; Increment vowel count
        inx                         ; Increment index
        cpx     #20                 ; Check if end of string
        bne     loop                ; Loop if not at end
        jmp     done                ; Jump to done if end of string
