
; Flight Reservation System

; Define constants
.CHARIN = $FFCF ; Input character from keyboard
.CHAROUT = $FFD2 ; Output character to be displayed

; Define memory locations for user input
DST = $0200 ; Destination
SEATS = $0201 ; Number of seats
YESNO = $0202 ; Yes or no

; Define memory locations for flight information
FLIGHT_DEST = $0300 ; Destination of the flight
FLIGHT_SEATS = $0301 ; Number of available seats
FLIGHT_BOOKED = $0302 ; Number of seats booked

; Initialize memory locations
    LDA #0
    STA FLIGHT_DEST
    STA FLIGHT_SEATS
    STA FLIGHT_BOOKED

MainLoop:
    ; Display menu
    LDA #"1. Check availability"
    JSR DisplayString
    LDA #"2. Book a flight"
    JSR DisplayString
    LDA #"3. Exit"
    JSR DisplayString

    ; Get user choice
    JSR GetInput

    CMP #$31
    BEQ CheckAvailability
    CMP #$32
    BEQ BookFlight
    CMP #$33
    BEQ Exit

    JMP MainLoop

CheckAvailability:
    ; Display available seats
    LDA FLIGHT_SEATS
    JSR DisplayNum

    JMP MainLoop

BookFlight:
    ; Display destinations
    LDA #"1. New York"
    JSR DisplayString
    LDA #"2. Los Angeles"
    JSR DisplayString

    ; Get user choice
    JSR GetInput

    CMP #$31
    BEQ NewYork
    CMP #$32
    BEQ LosAngeles

NewYork:
    ; Check availability for New York
    LDA FLIGHT_DEST
    CMP #"1"
    BEQ BookFlightError
    JMP BookFlightCheck

LosAngeles:
    ; Check availability for Los Angeles
    LDA FLIGHT_DEST
    CMP #"2"
    BEQ BookFlightError
    JMP BookFlightCheck

BookFlightCheck:
    ; Get number of seats
    LDA #"Enter number of seats: "
    JSR DisplayString
    JSR GetInput

    STA SEATS
    LDA SEATS
    CLC
    ADC FLIGHT_BOOKED
    BCC BookFlightSuccess

BookFlightError:
    LDA #"No seats available for this destination"
    JSR DisplayString
    JMP MainLoop

BookFlightSuccess:
    ; Book the flight
    LDA SEATS
    STA FLIGHT_BOOKED
    LDA FLIGHT_SEATS
    SEC
    SBC SEATS
    STA FLIGHT_SEATS

    LDA #"Flight booked successfully"
    JMP MainLoop

Exit:
    RTS

; Subroutines

DisplayString:
    LDY #0
PrintLoop:
    LDA [A],Y
    BEQ PrintEnd
    JSR PrintChar
    INY
    JMP PrintLoop
PrintEnd:
    RTS

DisplayNum:
    JSR PrintChar
    RTS

GetInput:
    LDA #$00
    STA [DST]

InputLoop:
    LDA CHARIN
    CMP #$08 ; Backspace
    BEQ Backspace
    CMP #$0D ; Enter
    BEQ Enter
    STA [DST]
    JMP InputLoop

Backspace:
    LDA #$20
    JSR PrintChar
    LDA #$08
    JSR PrintChar
    JMP InputLoop

Enter:
    LDA #$0D
    JSR PrintChar
    LDA #$00
    JSR PrintChar
    RTS

PrintChar:
    STA CHAROUT
    RTS

    .ORG $FFFC
    .WORD MainLoop
