
ORG $2000

String    .ASC "Hello world hello world"

WordCount .BLKB 10    ; array to store the word counts
WordPtr   .BLKW 10    ; array to store the pointers to words
Delimiter .BYTE $00   ; delimiter for splitting words

START:
    LDX #0
    LDY #0
    
GetNextWord:    
    LDA String, Y        ; load next character from string
    BEQ EndOfString      ; check for end of string
    CMP Delimiter        ; compare with delimiter
    BEQ UpdateWordPtr    ; if delimiter found, update word pointer
    INY                  ; increment index
    BNE GetNextWord
    
UpdateWordPtr:
    STY WordPtr, X       ; store pointer to current word
    INX                  ; increment word index
    LDA WordPtr, X
    STA WordCount, X     ; initialize word count to 0
    
    JMP GetNextWord
    
EndOfString:
    LDA #0
    STA WordPtr, X       ; store 0 to mark end of word pointers
    
    LDX #0
CountWords:
    LDA WordPtr, X       ; load address of next word
    BEQ DisplayCounts    ; check for end of word pointers
    
    LDX #0
CountLetters:
    LDA (WordPtr, X)     ; load next character of word
    BEQ EndOfWord        ; check for end of word
    INX                  ; increment letter index
    BNE CountLetters
    
EndOfWord:
    LDA WordCount, X     ; load current word count
    CLC
    ADC #1               ; increment word count
    STA WordCount, X     ; store updated word count
    
    INX                  ; increment word index
    BNE CountWords
    
DisplayCounts:
    LDX #0
    LDA WordCount, X     ; load current word count
    BEQ EndProgram       ; check for end of word counts
    
    JSR PrintWordCount   ; subroutine to print word count
    
    INX
    BNE DisplayCounts
    
EndProgram:
    BRK                  ; end program

PrintWordCount:
    LDY #0
    LDA WordPtr, X       ; load address of word
    JSR PrintString      ; subroutine to print word
    JSR PrintSpace       ; subroutine to print space
    LDA WordCount, X     ; load word count
    JSR PrintNumber      ; subroutine to print number
    RTS                  ; return from subroutine

PrintString:
    LDA (Y), Y           ; load next character of string
    BEQ EndPrintString   ; check for end of string
    JSR PrintChar        ; subroutine to print character
    INY                  ; increment index
    BNE PrintString

EndPrintString:
    RTS                  ; return from subroutine

PrintChar:
    ; print character
    RTS                  ; return from subroutine

PrintSpace:
    ; print space
    RTS                  ; return from subroutine

PrintNumber:
    ; print number
    RTS                  ; return from subroutine

END START
