
ORG $1000

START LDX #$00      ; Initialize X register to store position in text
      LDA TEXT,X    ; Load character from text at position X
      BEQ END       ; Check for end of text
      CMP #'#'       ; Check if character is a hash symbol
      BEQ FOUND      ; If character is a hash symbol, go to found
      INX            ; Increment X register
      BNE START      ; Loop back to start if not end of text
END   RTS

FOUND LDX #$00      ; Initialize X register to store position of hashtag
      INX            ; Move to next character after hash symbol
NEXT  LDA TEXT,X    ; Load character from text at position X
      BEQ PRINT     ; Check for end of hashtag
      CMP #' '       ; Check if character is a space
      BEQ PRINT     ; If character is a space, end of hashtag
      JSR PRINTCHAR  ; If not end of hashtag, print character
      INX            ; Move to next character
      BNE NEXT       ; Loop back to next character
      RTS

PRINT JSR PRINTNEWLINE ; Print newline before next hashtag
      RTS

PRINTCHAR STA $0200,X   ; Store character to memory location $0200 and increment X
         INC $0201      ; Increment memory location for next character
         RTS

PRINTNEWLINE LDA #<$0300  ; Load low byte of memory location for newline character
             STA $0200,X  ; Store newline character to memory location $0200 and increment X
             LDA #>$0300  ; Load high byte of memory location for newline character
             STA $0201    ; Store high byte of newline character
             RTS

TEXT .ASC "This is a #sample text with #hashtags and #hashtags #everywhere"

END START
