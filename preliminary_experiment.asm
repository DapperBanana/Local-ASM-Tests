
    .org $0200

START   LDX #0          ; Initialize X to point to the beginning of the string
        LDY #0          ; Initialize Y as the start of the longest palindrome
        LDA #$FF        ; Initialize A with the max length of palindrome found so far
LOOP    LDA INPUT,X     ; Load next character from the string into A
        BEQ DONE        ; If character is null, end of string reached
        STA TEMP1       ; Save character in TEMP1
        STX COUNT       ; Save count in COUNT for current character
        JSR CHECKPALINDROME ; Check if palindrome from current character

        CMP TEMP2      ; Compare current palindrome length with maximum palindrome length
        BCC LOOP       ; If current palindrome is shorter, continue to find longer palindromes
        
        STY START      ; If current palindrome is longer, update start and max length
        STA TEMP2      ; Update max length with current palindrome length
        BCS LOOP       ; Continue checking next characters

DONE    RTS

CHECKPALINDROME     
        LDA COUNT      ; Load current count into A
        STA TEMP3      ; Save it in TEMP3
        
        LDA COUNT      ; Copy count to X for LDX usage
        LDY #$00       ; Clear Y for palindrome checking
        
COMPARISON
        LDA INPUT,COUNT ; Load next character from the string into A
        STX INDEX       ; Store COUNT into INDEX for memory saving
        CMP INPUT,INDEX ; Compare current character with the next character in the string
        BNE NOTPALINDROME ; If not equal, then the string is not palindrome
        INY             ; Increment Y for next character
        DEC COUNT       ; Decrement count for end condition
        INC INDEX       ; Increment index for next character
        JMP COMPARISON

NOTPALINDROME
        LDX TEMP3      ; Load TEMP3 into X
        LDA INPUT,X    ; Load character from X
        STA TEMP1      ; Save it in TEMP1
        
        CMP TEMP2      ; Compare current palindrome length with max palindrome length
        BCC PALINDROME  ; If current palindrome is longer, update TEMP2
        RTS

PALINDROME
        LDX TEMP3      ; Load TEMP3 into X
        STA TEMP2      ; Save Y in TEMP2 as longest palindrome found
        RTS

INPUT   .byte "abcdeedcbama",0 ; Input string
TEMP1   .byte 0         ; Temporary storage for current character
TEMP2   .byte 0         ; Temporary storage for max palindrome length
TEMP3   .byte 0         ; Temporary storage for current count
COUNT   .byte 0         ; Current count for index in the string
INDEX   .byte 0         ; Temporary storage for index in the string

    .end
