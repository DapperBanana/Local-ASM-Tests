
         LDX #$00     ; Initialize index X to point to the start of the string
         LDY #$00     ; Initialize index Y to point to the end of the string
         
checkLoop:
         CPX Y        ; Compare X with Y
         BHS end      ; If X >= Y, all characters have been compared, exit the loop
         
         LDA $2000,X  ; Load character from the beginning of the string
         CMP $2000,Y  ; Compare with character from the end of the string
         BEQ continue ; If characters match, continue checking
         
         JSR notPalindrome ; If characters do not match, output "not a palindrome" message and end program
         
continue:
         INX          ; Move X to the next character in the string
         INY          ; Move Y to the previous character in the string
         JMP checkLoop ; Repeat comparison for the next pair of characters

end:
         JSR isPalindrome  ; Output "is a palindrome" message
         
         BRK          ; End program

 notPalindrome:
         LDA #$4E    ; 'N'
         JSR $FFDE   ; Output 'N'
         
         LDA #$4F    ; 'O'
         JSR $FFDE   ; Output 'O'
         
         LDA #$54    ; 'T'
         JSR $FFDE   ; Output 'T'
         
         LDA #$20    ; ' '
         JSR $FFDE   ; Output ' '
         
         LDA #$41    ; 'A'
         JSR $FFDE   ; Output 'A'
         
         LDA #$20    ; ' '
         JSR $FFDE   ; Output ' '
         
         LDA #$50    ; 'P'
         JSR $FFDE   ; Output 'P'
         
         LDA #$41    ; 'A'
         JSR $FFDE   ; Output 'A'
         
         LDA #$4C    ; 'L'
         JSR $FFDE   ; Output 'L'
         
         LDA #$49    ; 'I'
         JSR $FFDE   ; Output 'I'
         
         LDA #$4E    ; 'N'
         JMP $FFDE   ; Output 'N'
         
isPalindrome:
         LDA #$49    ; 'I'
         JSR $FFDE   ; Output 'I'
         
         LDA #$53    ; 'S'
         JSR $FFDE   ; Output 'S'
         
         LDA #$20    ; ' '
         JSR $FFDE   ; Output ' '
         
         LDA #$41    ; 'A'
         JSR $FFDE   ; Output 'A'
         
         LDA #$20    ; ' '
         JSR $FFDE   ; Output ' '
         
         LDA #$50    ; 'P'
         JSR $FFDE   ; Output 'P'
         
         LDA #$41    ; 'A'
         JSR $FFDE   ; Output 'A'
         
         LDA #$4C    ; 'L'
         JSR $FFDE   ; Output 'L'
         
         LDA #$49    ; 'I'
         JSR $FFDE   ; Output 'I'
         
         LDA #$4E    ; 'N'
         JMP $FFDE   ; Output 'N'
