
    .org $0200        ; Start program at memory address $0200

str1    .byte "10101011"   ; First string
str2    .byte "11111011"   ; Second string

        lda #0           ; Initialize counter for Hamming distance
        ldx #0           ; Initialize index for looping through strings

loop    lda str1,x       ; Load character from first string
        eor str2,x       ; XOR with character from second string
        clc              ; Clear carry flag
        bpl next         ; If result is positive, go to next character
        inc             ; Increment Hamming distance counter

next    inx              ; Increment index
        cpx #8           ; Check if end of strings
        bne loop         ; If not at end, continue loop

        sta $0300        ; Store Hamming distance result at memory address $0300

        rts              ; Return from subroutine

