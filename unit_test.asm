
        .org $8000

str1    .byte "hello",0
str2    .byte "hallo",0
result  .byte 0

start   lda #0          ; Initialize counter
        sta result

loop    ldy #0          ; Initialize inner loop counter
        lda str1, y     ; Load character from first string
        cmp str2, y     ; Compare with character from second string
        bne not_equal    ; Branch if characters are not equal
        
        inx             ; Increment counter if characters are equal

not_equal
        iny             ; Increment inner loop counter
        cpy #6          ; Check if end of string is reached
        bne loop

        lda result      ; Load current count
        clc
        adc #0x30       ; Convert to ASCII
        sta result

done    rts

        .end
