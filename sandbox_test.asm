
    .org $1000

    START:
        LDX #0        ; initialize index register
        STX DAY       ; initialize day counter
        STX CALORIE   ; initialize calorie counter

    INPUT:
        LDA PROMPT    ; load prompt message
        JSR PRINT     ; print prompt message

        JSR GETNUM    ; get user input for calorie count
        STA CALORIE   ; store input in calorie counter

        LDA PROMPT2   ; load secondary prompt message
        JSR PRINT     ; print secondary prompt message

        JSR GETNUM    ; get user input for workout duration
        STA DURATION  ; store input in duration counter

        INX           ; increment day counter
        TXA           ; transfer day counter to accumulator
        STA DAY       ; store incremented day counter

        LDA DAY       ; load day counter
        CMP #7        ; compare to max number of days
        BCC INPUT     ; branch if not equal to max number of days

        JSR RESULT    ; display results
        RTS           ; return to caller

    ; Subroutine to print a character
    PRINT:
        STA $f000     ; write to screen memory
        RTS           ; return to caller

    ; Subroutine to get user input for a number
    GETNUM:
        LDX #0
    LOOP1:
        JSR GETCHAR   ; get character input
        CMP #'0'      ; check if input is a digit
        BCC LOOP1     ; loop until input is a digit
        CMP #'9'
        BCS LOOP1
        STA TEMP,X    ; store input in temporary buffer
        INX           ; increment index to buffer
        JSR PRINT     ; echo input back to user
        CPX #3        ; check if 3 digits have been entered
        BNE LOOP1     ; loop until 3 digits have been entered
        LDA #$00
        STA work,x
        STY work+1
        STX work+2
        STX work+3
        STX work+4
        RTS

    ; Subroutine to get a character input from user
    GETCHAR:
        LDX #20       ; initialize counter
        LDY #$00
        JSR CHROUT    ; display cursor
    WAIT1:
        LDA $f000     ; read keyboard input
        CMP #$00      ; check if key has been pressed
        BEQ WAIT1     ; wait until key has been pressed
        STA TEMP,Y    ; store input in temporary buffer
        LDA TEMP,Y    ; load input from temporary buffer
        JSR PRINT     ; display input on screen
        LDA TEMP,Y
        RTS

    RESULT:
        LDX #0        ; initialize index register
        LDA #$0       ; clear the accumulator
        STA TOTAL

    SUMCAL:
        LDA CALORIE,X ; load calorie count for the day
        CLC           ; clear carry flag
        ADC TOTAL     ; add to total calorie count
        STA TOTAL     ; store total calorie count
        INX           ; increment index
        CPX #7        ; compare index to max number of days
        BCC SUMCAL    ; loop until all days are added

        LDA PROMPT3   ; load final message
        JSR PRINT     ; print final message

        LDA TOTAL     ; load total calorie count
        JSR PRINT     ; print total calorie count

        RTS

    .addr $E000
    DAY:    .byte 0
    .addr $E001
    CALORIE: .byte 0
    .addr $E002
    DURATION: .byte 0
    .addr $E003
    PROMPT: .byte 'Enter daily calorie count: '
    .addr $E004
    PROMPT2: .byte 'Enter workout duration in minutes: '
    .addr $E005
    PROMPT3: .byte 'Total calorie count for the week is: '

    TEMP:    .byte 3
    TOTAL:   .byte 0

