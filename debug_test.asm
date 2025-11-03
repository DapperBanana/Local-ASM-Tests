
; Constants
CARRIAGE_RETURN = $0D    ; ASCII code for carriage return
LINE_FEED = $0A          ; ASCII code for line feed

; Memory Locations
start
    .org $0200          ; Start address of program

    LDX #0             ; Initialize index register
print_menu
    LDA message,X      ; Load message character
    BEQ end_program    ; If end of the message, exit program
    JSR print_char     ; Print character
    INX                ; Increment index
    JMP print_menu     ; Repeat for next character

    RTS                ; End of program

print_char
    STA $FFD2          ; Print character to screen
    RTS                ; Return to main program

end_program
    BRK

message
    .text "Flight Reservation System", CARRIAGE_RETURN, LINE_FEED
    .text "1. Reserve a flight", CARRIAGE_RETURN, LINE_FEED
    .text "2. Cancel reservation", CARRIAGE_RETURN, LINE_FEED
    .text "3. View available flights", CARRIAGE_RETURN, LINE_FEED
    .text "4. Exit", CARRIAGE_RETURN, LINE_FEED
    .byte 0            ; End of message marker

