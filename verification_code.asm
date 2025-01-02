
.INCLUDE "vcs.h"

PALINDROME_YEAR = $FFFF

        .ORG $FC00

start   LDX #0                 ; initialize index to 0
check   LDA PALINDROME_YEAR,X  ; load digit from the year
        BEQ is_palindrome      ; check if end of year
        STA $FB                ; store current digit in $FB
        INX                    ; increment index
        JMP check              ; repeat until end of year

is_palindrome
        LDX #0                 ; reinitialize index to 0
check_palindrome
        LDA PALINDROME_YEAR,X  ; load digit from the year
        BEQ palindrome_found   ; check if end of year reached
        CMP $FB                ; compare current digit with stored digit
        BNE not_palindrome     ; branch if not equal
        INX                    ; increment index
        JMP check_palindrome    ; continue checking
not_palindrome
        LDA #0                 ; load 0 into Accumulator 
        STA $80                ; save accumulator value to myFlag
        RTS                    ; return from subroutine
palindrome_found
        LDA #1                 ; load 1 into Accumulator 
        STA $80                ; save accumulator value to myFlag
        RTS                    ; return from subroutine

halt    JMP halt

        .ORG $FFFC
        .WORD start
