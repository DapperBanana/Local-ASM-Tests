
START    LDX #0           ; Initialize index for first string
         STX INDEX1
         LDX #0           ; Initialize index for second string
         STX INDEX2

CHECK    LDA STR1, X      ; Load character from first string
         BEQ END          ; If end of string, go to END

         JSR SEARCH       ; Search for character in second string
         BEQ NOT_ANAGRAM  ; If not found, strings are not anagrams

         INX              ; Move to next character in first string
         JMP CHECK

NOT_ANAGRAM
         LDA #1           ; Set flag to indicate not anagrams
         STA ANAGRAM_FLAG
         JMP END

SEARCH   LDX #0           ; Initialize index for second string
         
SEARCH_LOOP
         LDA STR2, X      ; Load character from second string
         BEQ NOT_FOUND    ; If end of string, character not found
         CMP STR1, X      ; Compare characters
         BEQ FOUND        ; If found, exit loop
         INX              ; Move to next character in second string
         JMP SEARCH_LOOP

NOT_FOUND
         LDA #0           ; Character not found in second string
         RTS

FOUND
         LDA #1           ; Character found in second string
         RTS

END      BRK              ; End of program

INDEX1   .BYTE 0
INDEX2   .BYTE 0
ANAGRAM_FLAG .BYTE 0
STR1     .BYTE "LISTEN"   ; First string
STR2     .BYTE "SILENT"   ; Second string
         
         .ORG $FFFC
         .WORD START
