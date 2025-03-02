
    .org $1000       ; start address

string      .asciiz "madam"
stringLen   = * - string - 1

start       lda #0          ; clear accumulator
            sta index       ; clear index
            ldx #stringLen  ; load string length
            ldy #0          ; start from beginning

checkLoop   lda string,y    ; load character from beginning
            cmp string,x    ; compare character from end
            bne notPalindrome ; if not equal, not a palindrome
            iny             ; increment beginning index
            dex             ; decrement end index
            cpx index       ; check if reached middle
            bcs checkLoop   ; if not, continue checking

isPalindrome jmp palindromeFound ; string is a palindrome

notPalindrome
            jmp notPalindromeFound ; string is not a palindrome

palindromeFound
            lda #1          ; set flag to indicate palindrome
            jmp endProgram  ; end program

notPalindromeFound
            lda #0          ; clear flag to indicate not a palindrome
            jmp endProgram  ; end program

endProgram  sta isPalindromeFlag ; store flag
            rts

isPalindromeFlag .byte 0
index           .byte 0

            .end
