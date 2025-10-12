
        .org $0200       ; start address of the program
        
isIsogram:
        LDX #0          ; index pointer for outer loop, start at first character
checkNextChar:
        LDA str, X      ; load current character into accumulator
        BEQ isogram     ; if null terminator is reached, then it is an isogram
        JSR checkRepeat ; check if current character is repeated in the string
        BEQ notIsogram  ; if current character is repeated, then it is not an isogram
        INX             ; move to the next character in the string
        JMP checkNextChar ; check the next character in the string
        
isogram:
        RTS             ; return with isogram status
        
notIsogram:
        LDA #0          ; set accumulator to 0 to indicate not an isogram
        RTS             ; return with not isogram status
        
checkRepeat:
        STX index       ; store index of current character
        LDX #0          ; index pointer for inner loop, start at first character
checkNextChar2:
        CMP str, X      ; compare current character with rest of the string
        BEQ repeatFound ; if character is found again in the string, then it is not an isogram
        INX             ; move to the next character in the string
        CPX #255        ; check if end of string is reached
        BNE checkNextChar2 ; if not, check next character
        RTS             ; return if no repeat found
        
repeatFound:
        LDA #1          ; set accumulator to 1 to indicate repeat found
        RTS             ; return with repeat found status
        
        .org $FFFA       ; interrupt vector address
        .word isIsogram  ; set interrupt vector to start of program
        
str:
        .byte "hello", 0 ; example string to check for isogram
index   .byte 0         ; variable to store current index pointer
