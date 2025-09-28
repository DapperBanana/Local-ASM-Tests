
    .text
    .org $0200

start:
    ldx #$00         ; Initialize index to point to first character of string
    ldy #$01         ; Initialize second index to point to second character of string

next_char:
    lda input,x     ; Load current character into A
    beq is_isogram     ; If current character is null terminator, string is an isogram
    
check_duplicates:
    cmp input,y    ; Compare characters
    
    beq not_isogram        ; If characters are the same, string is not an isogram
    iny                ; Move to next character in string
    bne next_char     ; Continue checking until the end of the string
    
    rts                ; Return if no duplicates found
    
is_isogram:
    lda #'1' 
    jsr $ffd2           ; Print "1"
    rts
    
not_isogram:
    lda #'0'
    jsr $ffd2           ; Print "0"
    rts

    .data
input:
    .string "abcdefg"   ; Input string to check for isogram
    .byte $00           ; Null terminator
