

        ORG $0200
START   LDA #$00         ;Initialize index for input string
        STA $FB           ;Store index in zero page memory location        
        LDA $2000,X      ;Load character from input string
        BEQ END           ;If end of string, exit program
        JSR IS_PUNCTUATION ;Check if character is punctuation
        BCC NOT_PUNCTUATION ;If not punctuation, copy character
        JMP SKIP          ;If punctuation, skip character
NOT_PUNCTUATION
        STA $2100,X       ;Copy non-punctuation character to result string
        INX               ;Increment index for result string
SKIP
        INX               ;Increment index for input string
        JMP START         ;Go to next character in input string
END
        RTS

IS_PUNCTUATION
        CMP #'!'         ;Check if character is '!'
        BEQ IS_PUNCTUATION_END
        CMP #'.'         ;Check if character is '.'
        BEQ IS_PUNCTUATION_END
        CMP #','         ;Check if character is ','
        BEQ IS_PUNCTUATION_END
        CMP #'?'         ;Check if character is '?'
        BEQ IS_PUNCTUATION_END
        CMP #':'         ;Check if character is ':'
        BEQ IS_PUNCTUATION_END
        SBC #1           ;If not punctuation, clear carry flag
        RTS
IS_PUNCTUATION_END
        SEC              ;Set carry flag if character is punctuation
        RTS

