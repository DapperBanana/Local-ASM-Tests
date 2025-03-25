
    .org $0200                    ; set start address

start:
    ldx #$00                     ; initialize index register X
    ldy #$00                     ; initialize index register Y
    
    lda input,x                  ; load the first character of the string
    beq end                      ; if it is a null character, end the program
    
loop:
    inx                          ; increment index register X
    lda input,x                  ; load the next character
    cmp #" "                     ; compare to space character
    beq check_word               ; if it is a space character, check the word
    
    cmp #$00                     ; compare to null character
    bne loop                     ; if it is not a null character, continue loop
    
end:
    rts                          ; return from subroutine
    
check_word:
    lda word_count,y             ; load current word count
    iny                          ; increment index register Y
    clc                          ; clear carry bit
    adc #$01                     ; increment current word count
    sta word_count,y             ; store updated word count
    
    lda input,x                  ; load the first character of the next word
    beq end                      ; if it is a null character, end the program
    
    jmp loop                     ; continue loop

    .org $0300                    ; set start address for input variable

input:                           ; input string
    .byte "hello world hello abcde hello", 0

    .org $0400                    ; set start address for word_count variable

word_count:                    ; word count array
    .byte 0,0,0,0,0               ; initialize word count array
