
; Basic text-based calendar simulation in 6502 Assembly

        .org $0200    ; Start program at address $0200

        LDX #1       ; Set the starting day of the week to Sunday
        LDY #1       ; Set the starting day of the month to the first day

loop    ; Print the days of the week
        LDA weekdays, X
        JSR $FFD2    ; Call KERNAL routine to print character
        INX
        CPX #7       ; Check if end of week
        BNE loop

        JSR $FFD2    ; Print newline character
        LDY #1       ; Reset day of the month

month   ; Print the days of the month
        LDA #10      ; Load ASCII value for horizontal tab
        JSR $FFD2    ; Print horizontal tab character
        LDX #7       ; Set number of days in the month
        
day
        LDA #$2D     ; Load ASCII value for dash character
        JSR $FFD2    ; Print dash character
        LDA #2
        JSR $FFD2    ; Print space character
        LDA #1
        JSR $FFD2    ; Print digit in the ten's place
        LDA #0
        JSR $FFD2    ; Print digit in the one's place
        LDA #2
        JSR $FFD2    ; Print space character
        INY
        DEX
        CPX #0
        BNE day
        
        JSR $FFD2    ; Print newline character
        RTS

weekdays 
        .text "SuMoTuWeThFrSa"

        .end
