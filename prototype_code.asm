
        .org $0200  ; Start address
START   lda #0      ; Initialize vowel count to 0
        sta COUNT
  
LOOP    lda STR,X   ; Load a character from the string
        beq END     ; If it is null terminator, end loop
        jsr IS_VOWEL ; Check if character is a vowel
        cmp #1       ; If it is a vowel
        beq INC_COUNT  ; Increment count if vowel
        inx          ; Increment string index
        bra LOOP     ; Continue looping

INC_COUNT
        lda COUNT   ; Load vowel count
        clc         ; Clear carry flag
        adc #1      ; Increment count by 1
        sta COUNT   ; Store updated count
        inx         ; Increment string index
        bra LOOP    ; Continue looping

END     lda COUNT   ; Load final vowel count
        ; Here you can store or use the count as needed
        rts         ; Return from subroutine

IS_VOWEL
        lda #$20    ; Convert lowercase letter to uppercase
        cmp #'A'    ; Compare with 'A'
        bcc NOT_VOWEL  ; If less than 'A', not a vowel
        cmp #'E'    ; Compare with 'E'
        bcc NOT_VOWEL  ; If less than 'E', not a vowel
        cmp #'I'    ; Compare with 'I'
        bcc NOT_VOWEL  ; If less than 'I', not a vowel
        cmp #'O'    ; Compare with 'O'
        bcc NOT_VOWEL  ; If less than 'O', not a vowel
        cmp #'U'    ; Compare with 'U'
        bcc NOT_VOWEL  ; If less than 'U', not a vowel
        sec         ; Set carry flag to indicate it is a vowel
        rts

NOT_VOWEL
        clc         ; Clear carry flag to indicate it is not a vowel
        rts

COUNT   .byte 0     ; Variable to store vowel count
STR     .asciiz "HELLO, WORLD!"  ; Input string
