
    ; Input string is stored at address $4000
    ; Output the start address of the longest palindromic substring
    
    ORG $2000
    
start   LDX #$00                ; Initialize index for first character
        LDY #$01                ; Initialize index for second character
        
        LDA #$00                ; Initialize max length of palindrome
        STA $FD                 ; Store max length in $FD
        LDA #$00
        STA $FE                 ; Initialize start index of max palindrome in $FE
        
loop    LDA $4000,X             ; Load current character
        
        CMP #$00                ; Check for null terminator
        BEQ finish              ; If end of string, exit loop
        
        STA $FF                 ; Store current character in $FF
        
        JSR findPalindrome      ; Find palindrome starting at current character
        
        INX                     ; Move to next character
        INY
        
        JMP loop
        
findPalindrome
        LDY X                   ; Initialize Y to current character index
        LDX #$00                ; Initialize X to zero
        
check   LDA $FF,Y              ; Load character at current index
        STA $FB,X              ; Store character in temporary buffer
        INX
        INY
        
        LDA $FF,X              ; Load character at end index
        STA $FC,X              ; Store character in temporary buffer
        DEX
        
        CPX #$00               ; Check if end index reached
        BEQ compare            ; If end index reached, compare palindrome
        JMP check
        
compare LDX #$00                ; Initialize palindrome length
        LDY #$00                ; Initialize center index
        
next    LDA $FB,X              ; Load character at start index
        CMP $FC,X              ; Compare with character at end index
        BNE endCheck           ; If not equal, end comparison
        INX
        CPX $FD                 ; Check if end of palindrome reached
        BCC next
        JMP endCheck
        
endCheck LDA X                   ; Load current palindrome length
        CMP $FD                 ; Compare with max length
        BCS skipUpdate          ; If current length is less than max length, skip update
        
        STA $FD                 ; Update max length
        LDA Y                   ; Update start index of max palindrome
        STA $FE
        
skipUpdate
        RTS
        
finish  LDA $FE                 ; Load start index of max palindrome
        STA $80                 ; Store in output address
        RTS
        
        .END
