
; Count occurrences of each word in a string
; Assumes string starts at $1000 and ends at $10FF
; Result will be stored in memory starting at $1100
; Each word is separated by a space character

    .org $1000

string: .byte "hello world and hello again hello"
result: .block 26 ; Max 26 distinct words

    .org $2000

start:
    ldx #0            ; Initialize index register
next_word:
    lda string,x      ; Load character from string
    cmp #$20          ; Check for end of string
    beq end           ; If end of string, exit loop
    cmp #$00          ; Check for null terminator
    beq end           ; If null terminator, exit loop
    inx               ; Increment index register
    jmp next_word     ; Continue looping

end:
    dex               ; Decrement index Register to Adjust for null terminator

count_words:
    lda #0            ; Initialize accumulator
    sta result,x      ; Clear result for current word
    ldx #0            ; Initialize outer loop index register

next_outer:
    lda result,x      ; Load count for current word
    beq init_word     ; If count is 0, initialize word

    lda result,x      ; Load count for current word
    inx               ; Move to next word
    bne next_outer    ; Continue looping

init_word:
    lda #$20          ; Load space character
    sta result,x      ; Store space character as delimiter between words
    inx               ; Move to next word
    lda string,y      ; Load character from string
    beq end_count     ; If end of string, exit loop
    cmp #$00          ; Check for null terminator
    beq end_count     ; If null terminator, exit loop

count_occurrences:
    lda string,y
    cmp #$00          ; Check for null terminator
    beq end_count     ; If null terminator, exit loop
    cmp #$20          ; Check for space character
    beq end_count     ; If space character, exit loop

    pha               ; Push character onto stack
    lda result,x      ; Load count for current word
    clc
    adc #1            ; Increment count
    sta result,x      ; Store updated count
    pla               ; Pop character from stack
    iny               ; Move to next character
    jmp count_occurrences

end_count:
    inx               ; Move to next word
    lda string,y      ; Load character from string
    beq end_loop      ; If end of string, exit loop
    cmp #$00          ; Check for null terminator
    beq end_loop      ; If null terminator, exit loop
    jmp init_word     ; Process next word
    
end_loop:
    rts               ; Return from subroutine
