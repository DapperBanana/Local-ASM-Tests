
    .org $1000

start:
    ldx #0           ; Initialize index X to 0
    ldy #$FF         ; Initialize index Y to point to the end of the string

check_palindrome:
    cmpx y           ; Compare characters at indices X and Y
    beq is_palindrome ; If characters are equal, continue checking
    lda #$00         ; Set result to 0 (not a palindrome)
    sta $FF          ; Store result in memory location $FF
    rts

is_palindrome:
    inx              ; Increment index X
    dey              ; Decrement index Y
    cpx y            ; Check if indices have crossed each other
    bcc check_palindrome ; If not crossed, continue checking

    lda #$01         ; Set result to 1 (palindrome)
    sta $FF          ; Store result in memory location $FF
    rts

    .org $4000
input_string:
    .byte "A man a plan a canal Panama!", $00

    .org $FFFC
    .word start
