
        .org $1000

start   lda #$00        ; Initialize pointer for longest palindrome substring
        sta ptr
        lda strLen      ; Load the length of the string
        clc
        adc #$4         ; Adjust the length to start from the second character
        sta strLen
        lda strLen      ; Load the adjusted length of the string
        cmp #$01
        bcc end         ; If the length is less than 2, exit the program

loop    lda ptr         ; Load the current pointer
        clc
        adc #$01        ; Move to the next character
        sta ptr
        lda strLen      ; Load the length of the string
        cmp ptr         ; Compare the pointer with the length
        bcs end         ; If the pointer exceeds the length, exit the program

        jsr findPalindrome ; Find the longest palindromic substring starting from the current position
        lda maxLen
        cmp maxLength   ; Compare the length of the current palindrome with the maximum length found so far
        bcs updateMax   ; If the current palindrome is longer, update the maximum length
        jmp loop

updateMax lda ptr         ; Update the pointer for the starting position of the longest palindrome
        sta maxPtr
        lda maxLength   ; Update the length of the longest palindrome
        sta maxLen
        jmp loop

end     rts

findPalindrome
        lda ptr
        sta strStart    ; Save the starting position of the current substring
        clc
        adc #$01        ; Move to the next character
        sta ptr
        lda strLen
        cmp ptr
        bcs findPalindrome ; If the pointer exceeds the length, exit the subroutine

        lda str, x      ; Load the current character
        cmp str, y      ; Compare the current character with the character at the end of the substring
        bne nextChar    ; If they do not match, move to the next character
        
        lda ptr         ; Load the current pointer
        sta temp        ; Save the pointer for comparison
        clc
        adc #$01        ; Move to the next character
        sta ptr
        lda strLen
        cmp ptr
        bcs nextChar    ; If the pointer exceeds the length, move to the next character

        lda str, x      ; Load the next character
        cmp str, y      ; Compare the next character with the character at the end of the substring
        beq match       ; If they match, continue searching for the palindrome

nextChar
        lda temp        ; Restore the pointer for comparison
        sta ptr
        lda strLen
        cmp ptr
        bcs findPalindrome ; If the pointer exceeds the length, exit the subroutine

        jmp findPalindrome ; Otherwise, continue searching for the palindrome

match   lda ptr         ; Load the current pointer
        sta strEnd      ; Save the ending position of the current substring
        lda strStart
        sta temp        ; Save the starting position
        lda strEnd
        cmp strStart
        beq incLength   ; If the substring has a length of 2, increment the length of the palindrome
        
        clc
next    lda temp        ; Start comparing characters from the beginning of the current substring
        sta temp2
        lda strStart
        sta ptr
        lda strEnd
        sta temp
loop    lda str, x      ; Load the current character
        cmp str, y      ; Compare the current character with the character at the end of the substring
        bne notPalindrome ; If they do not match, the substring is not a palindrome
        
        lda ptr
        clc
        adc #$01        ; Move to the next character
        sta ptr
        lda temp
        cmp ptr
        bcs incLength   ; If all characters have been compared and match, increment the length of the palindrome

        jmp loop

notPalindrome
        lda temp2
        inc temp2
        lda strEnd
        cmp temp2
        bcs next        ; If the end position of the current substring has not been reached, continue checking characters

        lda maxLength
        cmp ptr         ; Compare the length of the current palindrome with the maximum length found so far
        bcs done
        lda ptr         ; Update the maximum length and pointer for the starting position of the longest palindrome
        sta maxLength
        lda strStart
        sta maxPtr

done    rts

incLength
        lda maxLength
        clc
        adc #$01        ; Increment the length of the palindrome
        sta maxLength
        lda temp
        cmp ptr
        bcs done
        jmp next

ptr     .byte $00
temp    .byte $00
temp2   .byte $00
maxPtr  .byte $00
strStart.byte $00
strEnd  .byte $00
maxLength.byte $00

; Data section
str     .byte "racecar", $00   ; Input string
strLen  .byte 0x06             ; Length of the input string
