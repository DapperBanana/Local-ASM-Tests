
    .org $0200         ; Start address
    
str1    .asc "listen"  ; First string
str2    .asc "silent"  ; Second string

checkAnagram:
    ldx #0            ; Initialize index for first string
loop1:
    lda str1,x       ; Load character from first string
    beq end1         ; Check for null terminator
    sta current_char1
    
    ldx #0            ; Initialize index for second string
loop2:
    lda str2,x       ; Load character from second string
    beq notAnagram   ; Check for null terminator
    cmp current_char1 ; Compare characters
    bne nextChar     ; If not equal, check next character
    
    inx              ; Increase index for second string
    jmp loop2        ; Repeat loop for second string
    
notAnagram:
    lda #$00         ; Set flag to indicate strings are not anagrams
    sta $0201
    
    rts              ; Return from subroutine

nextChar:
    inx              ; Increase index for second string
    lda str2,x       ; Load new character from second string
    bne loop2        ; Repeat loop for second string

end1:
    lda #$01         ; Set flag to indicate strings are anagrams
    sta $0201

    rts              ; Return from subroutine
