
        ORG $0200
START   LDX #0              ; Initialize index register for day count
        LDA #1              ; Initialize day counter
LOOP    JSR PRINT_MONTH     ; Print month header
        JSR PRINT_DAYS      ; Print days of the month
        INX                 ; Increment day count
        INCA                ; Increment day counter
        CPX #7              ; Check if the week is complete
        BNE LOOP            ; If not, continue printing days
        LDX #0              ; Reset day count for next week
        STA >08, X          ; Add line break after each week
        CPX #31             ; Check if month is complete
        BEQ END             ; If month is complete, end loop
        JMP NEXT_MONTH      ; Otherwise go to next month
END     BRK                 ; End program
PRINT_MONTH
        LDX #0              ; Reset index register for month
        LDA MONTH, X        ; Load month header from data
        JSR PRINT_STRING    ; Print month header
        RTS                 ; Return
PRINT_DAYS
        LDX #0              ; Reset index register for days
LOOP2   LDA DAY, X          ; Load day number from data
        JSR PRINT_STRING    ; Print day number
        INX                 ; Increment index register
        CPX #30             ; Check if end of the month is reached
        BEQ LOOP2           ; If not, continue printing days
        RTS                 ; Return
PRINT_STRING
        STA $01             ; Store character to be printed
        LDA $01             ; Load character
        JSR $FFD2           ; Print character
        RTS                 ; Return
NEXT_MONTH
        LDA #0              ; Load accumulator with zero
        STA >08             ; Clear screen
        INCA                ; Increment accumulator
        STA >09             ; Update month
        STX >0A             ; Update day count
        JMP START           ; Return to beginning of loop
MONTH   .BYTE "January"
        .BYTE "February"
        .BYTE "March"
        .BYTE "April"
        .BYTE "May"
        .BYTE "June"
        .BYTE "July"
        .BYTE "August"
        .BYTE "September"
        .BYTE "October"
        .BYTE "November"
        .BYTE "December"
DAY     .BYTE "1 "
        .BYTE "2 "
        .BYTE "3 "
        .BYTE "4 "
        .BYTE "5 "
        .BYTE "6 "
        .BYTE "7 "
        .BYTE "8 "
        .BYTE "9 "
        .BYTE "10"
        .BYTE "11"
        .BYTE "12"
        .BYTE "13"
        .BYTE "14"
        .BYTE "15"
        .BYTE "16"
        .BYTE "17"
        .BYTE "18"
        .BYTE "19"
        .BYTE "20"
        .BYTE "21"
        .BYTE "22"
        .BYTE "23"
        .BYTE "24"
        .BYTE "25"
        .BYTE "26"
        .BYTE "27"
        .BYTE "28"
        .BYTE "29"
        .BYTE "30"
        .BYTE "31"
        .END
