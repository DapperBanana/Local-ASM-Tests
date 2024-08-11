
.INCLUDE "6502.inc"

YEAR    .BYTE  "\0"
PALINDROME  .BYTE   "Year is a palindrome\0"
NON_PALINDROME  .BYTE   "Year is not a palindrome\0"

    LDA #"2"   ; Input year (e.g., 2022)
    STA YEAR

    LDX #0  ; Initialize index X to point to the beginning of the string
    LDY #3  ; Initialize index Y to point to the end of the string (4 characters)

CHECK_PALINDROME:   
    LDA YEAR, X  ; Load character at index X
    CMP YEAR, Y  ; Compare with character at index Y
    BNE NOT_PALINDROME  ; If characters don't match, jump to NOT_PALINDROME

    INX  ; Move to the next character from the beginning
    DEY  ; Move to the next character from the end

    CPY X  ; Check if we have reached the middle of the string
    BCC CHECK_PALINDROME  ; If Y is greater than X, continue checking characters

    JSR PRINT_PALINDROME  ; Print message that it's a palindrome year
    JMP END_PROGRAM

NOT_PALINDROME:
    JSR PRINT_NON_PALINDROME  ; Print message that it's not a palindrome year

END_PROGRAM:
    NOP  ; End of program

PRINT_PALINDROME:
    LDX #0  ; Initialize index X to point to the beginning of the string

PRINT_LOOP:
    LDA PALINDROME, X  ; Load character at index X
    BEQ END_PRINT  ; If null terminator, end printing
    JSR $FFD2  ; Print character
    INX  ; Move to the next character
    JMP PRINT_LOOP

END_PRINT:
    RTS  ; Return from subroutine

PRINT_NON_PALINDROME:
    LDX #0  ; Initialize index X to point to the beginning of the string

PRINT_LOOP_NON_PALINDROME:
    LDA NON_PALINDROME, X  ; Load character at index X
    BEQ END_PRINT_NON_PALINDROME  ; If null terminator, end printing
    JSR $FFD2  ; Print character
    INX  ; Move to the next character
    JMP PRINT_LOOP_NON_PALINDROME

END_PRINT_NON_PALINDROME:
    RTS  ; Return from subroutine
