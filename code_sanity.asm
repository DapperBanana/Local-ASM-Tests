
        .org $0200               ; Start program at address $0200
        
; Constants
NEWLINE = $0D                    ; ASCII code for newline character
SPACE = $20                      ; ASCII code for space character
QUESTION_PROMPT = "What is 2 + 2?" 
ANSWER = $04                     ; Correct answer is 4

; Reset Vector
        .org $FFFC               ; Reset vector address
        .word Start
        
; Main Program
Start:  SEI                      ; Disable interrupts
        CLD                      ; Disable decimal mode
        LDA #$FF                 ; Initialize stack pointer
        TXS
        
        LDX #0                   ; Clear X register
        LDY #0                   ; Clear Y register
        
        ; Print question prompt
PrintQuestion:
        LDA QUESTION_PROMPT, Y   ; Load next character from string
        BEQ GetUserInput         ; If end of string, get user input
        JSR PrintChar            ; Print character
        INY                      ; Move to next character
        JMP PrintQuestion
        
; Get user input
GetUserInput:
        LDA #$FF                 ; Initialize input variable
        STA $02FF                ; Store input at memory address $02FF
        
        ; Read user input
ReadUserInput:
        LDA $02FF                ; Load input
        BEQ ReadUserInput         ; Wait for user input
        CPX ANSWER               ; Compare input with correct answer
        BEQ PrintCorrectAnswer   ; If correct, print message
        
        ; Print incorrect answer message
        LDA #" "                  ; Load space character
        JSR PrintChar            ; Print space
        LDX #0                   ; Reset X register
        JMP Start                ; Restart quiz
        
; Print character
PrintChar:
        STA $D012                ; Store character in screen memory
        STA $9000, X             ; Output character to screen
        INX                      ; Move to next position
        RTS
        
; Print correct answer message
PrintCorrectAnswer:
        LDA #NEWLINE             ; Load newline character
        JSR PrintChar            ; Print newline
        LDX #0                   ; Reset X register
        LDA "Correct!"           ; Load message
        JSR PrintString          ; Print message
        JMP Start                ; Restart quiz

; Print string
PrintString:
PrintLoop:
        LDA $00, X               ; Load next character
        BEQ EndPrintString       ; If end of string, exit
        JSR PrintChar            ; Print character
        INX                      ; Move to next character
        JMP PrintLoop
EndPrintString:
        RTS
        
; Data Section
        .ascii "4"
        .ascii "What is 2 + 2?" 
        .byte 0
        
        .org $FFFA
        .word $0200               ; Start address
