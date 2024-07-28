
        .org $0200

start   LDA #0                  ; Clear screen
        LDX #0
clear   STA $02C0,X
        INX
        BNE clear
        LDX #0
again   JSR get_input           ; Get user input
        CMP #6                  ; Check if user input is valid
        BEQ valid_input
        JMP again               ; Loop back if input is invalid

valid_input
        STA $02C0,X             ; Store user input
        INX
        CPX #40                 ; Check if user input reaches end of screen
        BNE again

        LDX #0
        LDA #40
print   LDA $02C0,X             ; Print user input
        STA $0400,X
        INX
        CPX #40
        BNE print

        LDA #13
        STA $0400,X             ; Move cursor to next line
        LDA #10
        STA $0400+1,X
        RTS

get_input
        LDA $01                 ; Read key pressed by user
        CMP #13                 ; Check for return key
        BNE get_input
        RTS

        .org $FFFC
        .word start
