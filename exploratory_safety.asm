
; Text-based calendar simulation in 6502 Assembly
; Displaying a calendar for the month of January 2022

        .org $0600

MAIN    LDY #0               ; Initialize Y register to 0
LOOP    LDX #0               ; Initialize X register to 0
        LDA MONTH,X          ; Load month data into A register
        JSR PRINT           ; Print month name
        LDX #0               ; Initialize X register to 0
        LDA DAY,X            ; Load day data into A register
        JSR PRINT           ; Print day
        JSR NEWLINE         ; Move to next line
        INY                  ; Increment Y register
        CPY #7               ; Compare Y register with 7 (number of days in a week)
        BNE LOOP             ; If Y not equal to 7, loop back to display next day
        RTS                  ; Return from subroutine

PRINT   STA $D020            ; Write character to screen
        STA $D021            ; Write color to screen
        RTS

NEWLINE LDA #13              ; ASCII code for newline character
        JSR PRINT           ; Print newline
        LDA #10              ; ASCII code for carriage return
        JSR PRINT           ; Print carriage return
        RTS

MONTH   .byte "January", 0
DAY     .byte "1", 0

        .end
