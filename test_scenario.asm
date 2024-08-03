
; Define strings to compare
String1 .asciiz "listen"
String2 .asciiz "silent"

; Define variables
counter .byte 0

; Start of program
START:
    ldx #0             ; Initialize index to 0
    lda counter        ; Load current counter value
    sta $fb           ; Store it in zero page address
    lda String1, x    ; Load character from String1
    cmp #0             ; Check if end of string
    beq EXIT           ; If end of the string, exit loop
    jsr CHECK_ANAGRAM  ; Call function to check anagram
    inx                ; Increment index
    jmp START          ; Repeat loop

CHECK_ANAGRAM:
    lda String2, x    ; Load character from String2
    cmp #0             ; Check if end of string
    beq NOT_ANAGRAM    ; If end of the string, not anagram
    cmp String1, x     ; Compare character with String1
    bne NOT_ANAGRAM    ; If not equal, not an anagram
    inx                ; Increment index
    jmp CHECK_ANAGRAM  ; Repeat loop

NOT_ANAGRAM:
    lda #0             ; Set counter to 0
    sta counter
    rts                ; Return from subroutine

EXIT:
    rts                ; End of program
