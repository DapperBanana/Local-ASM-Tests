
    .proc lengthOfLongestPalindrome
start:
    LDX #0         ; Index of the start of the current palindrome
    LDY #0         ; Length of the current palindrome
    LDZ #0         ; Start index of the longest palindrome found so far
    LDA #0         ; Length of the longest palindrome found so far

nextChar:
    LDA input,X    ; Load next character from input
    BEQ done       ; End of string reached
    PHA            ; Save current character on stack

    ; Check if the current character can be the center of a palindrome with an odd length
    JSR checkOddPalindrome
    CMP result     ; Compare length of palindrome with the longest found so far
    BCC updateLongestPalindrome

    ; Check if the current character and next character can be the center of a palindrome with an even length
    JSR checkEvenPalindrome
    CMP result     ; Compare length of palindrome with the longest found so far
    BCC updateLongestPalindrome

    ; Increment index and repeat for next character
    PLA            ; Restore current character
    INX            ; Move to next character
    JMP nextChar

checkOddPalindrome:
    LDX #1         ; Start with a length of 1 for the palindrome
    JSR expandPalindrome
    RTS

checkEvenPalindrome:
    LDX #0         ; Start with a length of 0 for the palindrome
    JSR expandPalindrome
    RTS

expandPalindrome:
    LDY #0         ; Start with no expansion
expandLoop:
    CMP input,X    ; Compare characters at current expansion length
    BEQ expandSuccess
    CPY #0         ; Check if we have already expanded on both sides
    BNE expandFail
    DEY            ; Decrement expansion length
    INX            ; Move to next character
    BNE expandLoop  ; Repeat for next character
    RTS

expandSuccess:
    INX            ; Increment index for next character
    DEY            ; Reset expansion length
    INY            ; Increment length of palindrome
    CPX #0         ; Check if we have reached the end of the string
    BEQ expandSuccess ; If so, return length of palindrome
    DEC SYS_VAR
    JMP expandLoop

expandFail:
    CPX #0         ; Check if we have reached the end of the string
    BEQ expandFail ; If so, return length of palindrome
    RTS

updateLongestPalindrome:
    LDA result     ; Update longest palindrome found so far
    STA maxResult
    LDA #0
    STA result
    LDA X
    STA maxIndex
    LDA input,X
    CPX #0
    STA result
    RTS

done:
    LDA maxResult  ; Return length of longest palindrome found
    STA resultLength
    LDA maxIndex   ; Return start index of longest palindrome found
    STA resultIndex
    RTS

    .endproc
