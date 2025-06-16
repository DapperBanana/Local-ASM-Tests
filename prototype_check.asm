
START    LDX #0               ; Initialize index
         LDY #0               ; Initialize length counter

GETCHAR  LDA INPUT,Y          ; Load character from input string
         BEQ CHECKPALINDROME  ; If end of string, go to check palindrome
         STA TEMP,X           ; Store character to temporary buffer
         INY                  ; Increment Y (length counter)
         INX                  ; Increment X (index)
         BNE GETCHAR          ; Continue loop

CHECKPALINDROME
         LDX #0               ; Reset index for comparison
         LDY #$FF             ; Set length counter to last index
         
COMPARE  LDA TEMP,X           ; Load character from temporary buffer
         CMP TEMP,Y           ; Compare with corresponding character
         BEQ MATCH            ; If match, continue comparison
         LDA #$00             ; Set zero flag (indicating not a palindrome)
         BRA DONE             ; Exit loop

MATCH    INX                  ; Increment to next character for comparison
         DEY                  ; Decrement to previous character for comparison
         CPX Y                ; Check if reached middle of string
         BCC COMPARE          ; If not, continue comparison

DONE     ; Check zero flag to determine if palindrome
         BEQ ISPALINDROME      ; If zero flag set, it's a palindrome
         JMP NOTPALINDROME    ; If zero flag not set, it's not a palindrome

ISPALINDROME
         ; Code for a valid palindrome sentence
         ; Print message or set flag to indicate it's a palindrome
         RTS

NOTPALINDROME
         ; Code for an invalid palindrome sentence
         ; Print message or set flag to indicate it's not a palindrome
         RTS

INPUT    .ASCIC "A man, a plan, a canal, Panama!"
TEMP     .BLKB 256             ; Temporary buffer to store input string

         .END
