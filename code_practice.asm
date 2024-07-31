
; 6502 Assembly program for a basic personality quiz

        .org    $6000
        .charset "ABCDEF"
        
START   LDA     #<QUIZ_QUESTION
        STA     $02
        LDA     #>QUIZ_QUESTION
        STA     $03
        
LOOP    LDX     #0
        LDA     ($02),X
        BEQ     END
        JSR     $FFD2   ; Output character
        INX
        JMP     LOOP

END     RTS

QUIZ_QUESTION
        .text "Welcome to the personality quiz!\n"
        .text "1. Do you enjoy spending time outdoors?\n"
        .text "A. Yes\n"
        .text "B. No\n"
        .text "C. Sometimes\n"
        .byte $00
