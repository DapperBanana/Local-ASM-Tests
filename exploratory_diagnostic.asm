
        .org $0200

start   LDX #0              ; Initialize X register for loop

print_month:
        LDA month_name, X   ; Load month name from table
        JSR print_string    ; Print month name
        JSR print_newline    ; Print newline
        
        LDA #0
next_day:
        JSR print_day_header ; Print day header
        JSR print_newline    ; Print newline

        INX                  ; Increment X for next day
        CPX #31              ; Compare to end of month
        BCC next_day         ; If less than 31, print next day

        JMP print_month      ; Print next month

print_string:
        TAX                  ; Save ASCII character in X
print_char:
        LDY #0               ; Initialize Y for loop
print_next_char:
        LDA (string_ptr), Y  ; Load ASCII character from string
        BEQ print_done       ; If null terminator, print done
        JSR $ffd2            ; KERNAL routine to print character
        INY
        BNE print_next_char
print_done:
        RTS

print_newline:
        LDA #13              ; Print carriage return
        JSR $ffd2
        LDA #10              ; Print line feed
        JMP $ffd2

print_day_header:
        LDA #32              ; ASCII space character
        JSR $ffd2
        LDA #45              ; ASCII hyphen character
        JSR $ffd2
        LDA #45              ; ASCII hyphen character
        JSR $ffd2
        LDA #32              ; ASCII space character
        JSR $ffd2
        RTS

month_name:
        .text "January", 0
        .text "February", 0
        .text "March", 0
        .text "April", 0
        .text "May", 0
        .text "June", 0
        .text "July", 0
        .text "August", 0
        .text "September", 0
        .text "October", 0
        .text "November", 0
        .text "December", 0

        .text " ", 0
string_ptr:
        .word month_name

        .end
