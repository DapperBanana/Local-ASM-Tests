
        ldx #0          ; Initialize index to 0
loadstr lda str1,x     ; Load character from first string
        beq end        ; If null terminator, end of string
        tax            ; Save character to X register
        lda str2,x     ; Load character from second string
        tax            ; Save character to X register
        cmp           ; Compare characters
        bne diff       ; If different, increment counter
        inx            ; Increment index
        bra loadstr    ; Continue looping

diff    iny            ; Increment difference counter
        inx            ; Move to next character
        bra loadstr    ; Continue looping

end     ; End of strings, print the difference count
        ; The difference count is stored in Y register
        ; You can use this value as needed for further processing

str1    .asciiz "Hello"
str2    .asciiz "Hxllo"
