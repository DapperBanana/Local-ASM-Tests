
      .org $0200
START LDA STRING   ; Load address of the string
      STA STR_ADDR
      LDA #0
      STA MAX_LEN   ; Initialize max length to 0
      LDA #0
      STA PAL_START ; Initialize start index of palindrome
      STA PAL_END   ; Initialize end index of palindrome
      
LOOP  LDX #0        ; Loop through each character of the string
CHECK LDA STR_ADDR, X   ; Load current character
      BEQ END       ; Check for end of string
      STA CURR_CHAR
      
      LDA #1
      STA CURR_LEN  ; Initialize current length to 1
      
      LDX #1        ; Look for even length palindromes
      JSR CHECK_PAL; Check for palindrome
      LDX #2        ; Look for odd length palindromes
      JSR CHECK_PAL; Check for palindrome
    
      INX            ; Move to the next character
      JMP LOOP       ; Continue looping
      
CHECK_PAL
      LDA STR_ADDR, X   ; Load the next character
      CMP #0
      BEQ END_CHECK     ; If end of string, skip
      STA NEXT_CHAR
      LDA CURR_CHAR       ; Compare the current and next characters
      CMP NEXT_CHAR
      BNE END_CHECK     ; If not equal, not a palindrome
      
      DEX
      INC CURR_LEN      ; Increment the length of the palindrome
      LDA CURR_LEN
      CMP MAX_LEN       ; Compare with the max length
      BCC UPDATE_PAL    ; If longer, update the start and end index
      
      END_CHECK JMP $FF00  ; Continue checking for palindrome
      
UPDATE_PAL
      LDA CURR_LEN
      STA MAX_LEN       ; Update the max length
      LDA STR_ADDR
      CLC
      ADC X
      STA PAL_END      ; Update the end index
      SEC
      SBC CURR_LEN
      STA PAL_START    ; Update the start index
      JMP $FF00        ; Continue checking for palindrome
      
END   BRK              ; End of program
      
STRING .asc "ABACDGDCABA",0 ; Input string
STR_ADDR .byte 0         ; Address of the string
CURR_CHAR .byte 0        ; Current character
NEXT_CHAR .byte 0        ; Next character
CURR_LEN .byte 0         ; Current palindrome length
MAX_LEN .byte 0          ; Max palindrome length
PAL_START .byte 0        ; Start index of max palindrome
PAL_END .byte 0          ; End index of max palindrome

      .end
