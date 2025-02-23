
        .text
        .org $2000
        
string1: .asciiz "listen"
string2: .asciiz "silent"
        
        lda #0              ; Initialize index
        sta index
        
loop:   lda string1, x     ; Load character from first string
        cmp #0              ; Check for end of string
        beq done            ; If end of string, exit loop
        sta char1
        
        lda string2, x     ; Load character from second string
        cmp #0              ; Check for end of string
        beq not_anagram     ; If end of string, not an anagram
        sta char2
        
        cmp char1           ; Compare characters
        bne not_anagram     ; If characters are not equal, not an anagram
        
        inx                 ; Increment index
        bra loop            ; Repeat loop
        
not_anagram:
        lda #0              ; Set flag to indicate not an anagram
        sta is_anagram
        
done:   lda is_anagram      ; Load flag
        beq print_result    ; If not an anagram, print result
        
        lda string1         ; Load address of first string
        jsr print_string    ; Print first string
        
        lda #','
        jsr print_char      ; Print comma
        
        lda string2         ; Load address of second string
        jsr print_string    ; Print second string
        
        jmp exit
        
print_result:
        lda #1              ; Set flag to indicate anagram
        sta is_anagram
        
        lda #$41            ; Load 'Y'
        jsr print_char      ; Print 'Y'
        
        lda #$45            ; Load 'E'
        jsr print_char      ; Print 'E'
        
        lda #$53            ; Load 'S'
        jsr print_char      ; Print 'S'
        
        lda #$21            ; Load '!'
        jsr print_char      ; Print '!'
        
exit:   rts
        
print_string:
        ldy #0              ; Initialize index
print_loop:
        lda (x), y          ; Load character from string
        beq print_end       ; If end of string, exit loop
        jsr print_char      ; Print character
        iny                 ; Increment index
        bra print_loop      ; Repeat loop
        
print_end:
        rts
        
print_char:
        sta $D012           ; Write character to screen
        rts
        
        .data
index:  .byte 0
char1:  .byte 0
char2:  .byte 0
is_anagram: .byte 0
