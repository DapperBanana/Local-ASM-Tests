
;-------------------------------
; Job Application System Program
;-------------------------------

; Constants
BUFFER_SIZE = $100
JOB_TITLE_PROMPT = "Enter job title: "
NAME_PROMPT = "Enter your name: "
EXPERIENCE_PROMPT = "Enter years of experience: "
QUALIFICATION_PROMPT = "Enter qualifications: "
SUCCESS_MESSAGE = "Job application submitted successfully!"

; Variables
Buffer = $00
JobTitle = $10
Name = $20
Experience = $30
Qualifications = $40

; Main program
LDA #BUFFER_SIZE
STA Buffer

; Prompt user to enter job title
LDA #" "
JSR $FFD2 ; print character
LDA #JOB_TITLE_PROMPT
JSR PrintString
JSR GetUserInput
STA JobTitle

; Prompt user to enter name
LDA #" "
JSR $FFD2 ; print character
LDA #NAME_PROMPT
JSR PrintString
JSR GetUserInput
STA Name

; Prompt user to enter years of experience
LDA #" "
JSR $FFD2 ; print character
LDA #EXPERIENCE_PROMPT
JSR PrintString
JSR GetUserInput
STA Experience

; Prompt user to enter qualifications
LDA #" "
JSR $FFD2 ; print character
LDA #QUALIFICATION_PROMPT
JSR PrintString
JSR GetUserInput
STA Qualifications

; Submit job application
LDA #" "
JSR $FFD2 ; print character
LDA #SUCCESS_MESSAGE
JSR PrintString

JMP End

; Procedure to print a string
PrintString:
    LDY #0
PrintLoop:
    LDA (Y,X)
    BEQ PrintEnd
    JSR $FFD2 ; print character
    INY
    JMP PrintLoop
PrintEnd:
    RTS

; Procedure to get user input
GetUserInput:
    LDX Buffer
    LDY #0
    STY $FFD0 ; set keyboard buffer pointer
    JSR $FFCF ; get keyboard input
    STA (X)
    INX
    STX Buffer
    RTS

End:
    BRK
