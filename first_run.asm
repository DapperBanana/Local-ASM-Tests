
    .org $8000

start:
    lda #$00                ; Initialize index to 0
    sta index
    
    ldx #$00                ; Initialize checksum to 0
    stx checksum
    
    lda #$00                ; Initialize digit count to 0
    sta count
    
    ldy #$00                ; Initialize loop index to 0
    lda text,y             ; Load first character of the string
    
check_digit:
    cpy #$10                ; Check if end of string is reached
    beq end_check
    
    cmp #$30                ; Check if character is a digit
    bcc invalid
    
    cmp #$39
    bcs invalid
    
    inx                     ; Increment digit count
    iny                     ; Increment loop index
    
    lda text,y             ; Load next character of the string
    
    bmi check_digit         ; Check if negative (reached end of string)
    bne check_digit         ; Check if not null terminator
    
    lda count
    cmp #$10                ; Check if exactly 16 digits
    
    bne invalid
    
    lda checksum
    and #$0F                ; Check if checksum is a multiple of 10
    beq valid
    
invalid:
    lda #'0'                ; Output 'Invalid' message
    jsr $ffd2
    
    lda #'n'
    jsr $ffd2
    
    lda #'v'
    jsr $ffd2
    
    lda #'a'
    jsr $ffd2
    
    lda #'l'
    jsr $ffd2
    
    lda #'i'
    jsr $ffd2
    
    lda #'d'
    jsr $ffd2
    
    jmp end
    
valid:
    lda #'V'                ; Output 'Valid' message
    jsr $ffd2
    
    lda #'a'
    jsr $ffd2
    
    lda #'l'
    jsr $ffd2
    
    lda #'i'
    jsr $ffd2
    
    lda #'d'
    jsr $ffd2
    
end:
    rts

end_check:
    jmp invalid

checksum:
    .byte $02, $04, $06, $08, $01, $02, $03, $04, $05, $06, $07, $08, $09, $01, $03, $01

index:
    .byte $00

count:
    .byte $00

text:
    .asciiz "1234567890123456"
