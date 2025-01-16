
.org $0200

start:
    lda #<inputString   ; load address low byte
    sta $fb            ; store it in zero page
    lda #>inputString   ; load address high byte
    sta $fc            ; store it in zero page

    ldx #0              ; initialize index to zero
    ldy #0              ; initialize index to zero
    lda (fb),y          ; load first character
    cmp #$00            ; check for null terminator
    beq end             ; if end of string, go to end

check:
    lda (fb),y          ; load next character
    beq palindrome      ; if null terminator, it's a palindrome
    iny                 ; increment index
    cpx #0              ; check if index is zero
    beq check           ; if index is zero, get the other end
    cpx #10             ; check if index is greater than 10
    beq end             ; if greater than 10, not a palindrome
    lda (fb),y          ; load character from other end
    cmp (fb),x          ; compare with the character from start
    beq check           ; if equal, continue checking
    jmp end             ; if not equal, it's not a palindrome

palindrome:
    lda #$01            ; set result to 1 (true)
    jmp end

end:
    sta $fa            ; store result in zero page
    lda $fa            ; load result
    hlt                ; halt execution

inputString:
    .asciiz "A man a plan a canal Panama"

    .end start
