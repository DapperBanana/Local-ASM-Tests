
        ORG $2000
        
        ; Constants
        NEWLINE = $0D
        
        ; Input strings
        STRING1 .ASC "LISTEN"
        STRING2 .ASC "SILENT"
        
        ; Memory locations for storing character counts
        COUNT1  = $0100
        COUNT2  = $0110
        
        ; Program entry point
        LDA #0
        STA COUNT1, X
        STA COUNT2, X
        
CHECK_ANAGRAM:
        LDA STRING1, X
        BEQ DONE
        
        INX
        CLC
        ADC #1
        STA COUNT1, X
        
        LDA STRING2, X
        INX
        CLC
        ADC #1
        STA COUNT2, X
        
        JMP CHECK_ANAGRAM
        
DONE:
        LDX #0
CHECK_COUNTS:
        LDA COUNT1, X
        CMP COUNT2, X
        BNE NOT_ANAGRAM
        
        INX
        CPX #6 ; Check if all characters have been compared
        BNE CHECK_COUNTS
        
        ; Print result
        LDA #'Y'
        JSR PRINTCHAR
        JMP EXIT
        
NOT_ANAGRAM:
        LDA #'N'
        JSR PRINTCHAR
        
EXIT:
        BRK

PRINTCHAR:
        STA $D000 ; Output character to screen
        LDA NEWLINE
        STA $D000 ; Output newline character to screen
        RTS
