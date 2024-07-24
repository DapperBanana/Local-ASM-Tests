
        .org $0600

string1  .byte "ABCD", 0
string2  .byte "ACD", 0
result   .byte 0

start    lda #$00
         sta result

         ldx #$00         ; Initialize index for string1
loop1    lda string1, x  ; Load character from string1
         beq done         ; Check for end of string1
         
         ldy #$00         ; Initialize index for string2
loop2    lda string2, y  ; Load character from string2
         beq next         ; Check for end of string2
         
         cmp string1, x   ; Compare character from string1
         bne skip         ; If not equal, skip to next character
         
         cmp string2, y   ; Compare character from string2
         beq match        ; If equal, go to match
         
         inc y            ; Move to next character in string2
         jmp loop2        ; Continue looping through string2

match    inc result       ; Increment length of common subsequence
         inc x            ; Move to next character in string1
         inc y            ; Move to next character in string2
         jmp loop1        ; Continue looping through string1

skip     inc y            ; Move to next character in string2
         jmp loop2        ; Continue looping through string2

next     inc x            ; Move to next character in string1
         jmp loop1        ; Continue looping through string1

done     rts              ; Return from subroutine
