
; Calendar Simulator
; Simulates a basic text-based calendar
; Displays the days of the week (Sun-Sat) and the dates of the month

    .org $1000

    LDA #<message
    STA $02
    LDA #>message
    STA $03
    LDX #$00

print_days:
    LDA days, X
    JSR $FFD2
    INX
    CPX #$07
    BNE print_days

    LDX #$00

print_dates:
    LDA dates, X
    JSR $FFD2
    INX
    CPX #$07
    BNE print_dates

    RTS

days:
    .byte "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    
dates:
    .byte " 1", " 2", " 3", " 4", " 5", " 6", " 7"

message:
    .asc "Basic Text-Based Calendar"

    .end
