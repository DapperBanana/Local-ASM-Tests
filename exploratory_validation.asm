
.INCLUDE "6502.INC" ; Include the necessary macros for 6502 Assembly

        ORG $0600     ; Start of program memory

START   LDX #$00      ; Initialize index register X with 0
        LDY #$00      ; Initialize index register Y with 0

PRINT   LDA MENU,Y    ; Load next menu option
        BEQ END       ; Check if end of menu, if so, jump to end
        JSR PRINT_STR ; Print menu option
        INY           ; Increment Y
        JMP PRINT     ; Continue printing menu options

END     RTS           ; Return from subroutine

PRINT_STR
        JSR $FDED     ; Print string routine
        RTS           ; Return from subroutine

MENU    .ASC "1. Pasta with tomato sauce\n"
        .ASC "2. Grilled chicken with vegetables\n"
        .ASC "3. Caesar salad\n"
        .ASC "4. Homemade pizza\n"
        .ASC "\0"      ; Null-terminated string to mark end of menu

        .END          ; End of program
