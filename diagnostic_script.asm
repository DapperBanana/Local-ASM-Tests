
; 6502 Assembly program to check if a given string is a valid email address

    ; Set up variables
    .org $0200             ; Start address

emailString:
    .asciiz "example@email.com"  ; Change this to test different email addresses
    emailLength = * - emailString
    
    ; Initialize counters
    LDA #0                  
    STA currentIndex
    STA atSignCount
    
    ; Main loop to check email format
checkLoop:
    LDA emailString, X         ; Load next character from emailString
    BEQ validEmail             ; If end of string, email is valid
    
    CMP #'@'
    BEQ foundAtSign
    
    INX                        ; Increment index
    JMP checkLoop
    
foundAtSign:
    INC atSignCount
    
    INX                        ; Move to next character
    LDA emailLength
    CMP currentIndex
    BCC invalidEmail           ; If end of string, email is invalid
    
    JMP checkLoop
    
validEmail:
    LDA atSignCount
    CMP #1                     ; Ensure there is exactly one '@' character
    
    BNE invalidEmail
    
    ; Add more validation checks here if needed
    
    ; Print message indicating valid email
    LDA #'V'
    JSR $FFD2  ; COUT
    LDA #'a'
    JSR $FFD2
    LDA #'l'
    JSR $FFD2
    LDA #'i'
    JSR $FFD2
    LDA #'d'
    JSR $FFD2
    RTS

invalidEmail:
    ; Print message indicating invalid email
    LDA #'I'
    JSR $FFD2  ; COUT
    LDA #'n'
    JSR $FFD2
    LDA #'v'
    JSR $FFD2
    LDA #'a'
    JSR $FFD2
    LDA #'l'
    JSR $FFD2
    RTS

    ; End of program
    .org $FFFC
    .word $0200
