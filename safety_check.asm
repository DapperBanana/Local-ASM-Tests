
        .org $0200

START   LDX #0          ; Set X register to 0
        LDA #9          ; Load month number (September)
        STA $C000       ; Store month number to memory address $C000
LOOP    LDA $C000       ; Load month number from memory address $C000
        CMP #1          ; Compare with January
        BEQ JANUARY     ; Branch if equal to January
        CMP #2          ; Compare with February
        BEQ FEBRUARY    ; Branch if equal to February
        CMP #3          ; Compare with March
        BEQ MARCH       ; Branch if equal to March
        CMP #4          ; Compare with April
        BEQ APRIL       ; Branch if equal to April
        CMP #5          ; Compare with May
        BEQ MAY         ; Branch if equal to May
        CMP #6          ; Compare with June
        BEQ JUNE        ; Branch if equal to June
        CMP #7          ; Compare with July
        BEQ JULY        ; Branch if equal to July
        CMP #8          ; Compare with August
        BEQ AUGUST      ; Branch if equal to August
        CMP #9          ; Compare with September
        BEQ SEPTEMBER   ; Branch if equal to September
        CMP #10         ; Compare with October
        BEQ OCTOBER     ; Branch if equal to October
        CMP #11         ; Compare with November
        BEQ NOVEMBER    ; Branch if equal to November
        CMP #12         ; Compare with December
        BEQ DECEMBER    ; Branch if equal to December

JANUARY LDA #$4C        ; Load ASCII value for 'L'
        JSR $FFD2       ; Print character to screen
        LDA #$54        ; Load ASCII value for 'T'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

FEBRUARY LDA #$46       ; Load ASCII value for 'F'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

MARCH   LDA #$4D        ; Load ASCII value for 'M'
        JSR $FFD2       ; Print character to screen
        LDA #$41        ; Load ASCII value for 'A'
        JSR $FFD2       ; Print character to screen
        LDA #$52        ; Load ASCII value for 'R'
        JSR $FFD2       ; Print character to screen
        LDA #$43        ; Load ASCII value for 'C'
        JSR $FFD2       ; Print character to screen
        LDA #$48        ; Load ASCII value for 'H'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

APRIL   LDA #$41        ; Load ASCII value for 'A'
        JSR $FFD2       ; Print character to screen
        LDA #$50        ; Load ASCII value for 'P'
        JSR $FFD2       ; Print character to screen
        LDA #$52        ; Load ASCII value for 'R'
        JSR $FFD2       ; Print character to screen
        LDA #$49        ; Load ASCII value for 'I'
        JSR $FFD2       ; Print character to screen
        LDA #$4C        ; Load ASCII value for 'L'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

MAY     LDA #$4D        ; Load ASCII value for 'M'
        JSR $FFD2       ; Print character to screen
        LDA #$41        ; Load ASCII value for 'A'
        JSR $FFD2       ; Print character to screen
        LDA #$59        ; Load ASCII value for 'Y'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

JUNE    LDA #$4A        ; Load ASCII value for 'J'
        JSR $FFD2       ; Print character to screen
        LDA #$55        ; Load ASCII value for 'U'
        JSR $FFD2       ; Print character to screen
        LDA #$4E        ; Load ASCII value for 'N'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

JULY    LDA #$4A        ; Load ASCII value for 'J'
        JSR $FFD2       ; Print character to screen
        LDA #$55        ; Load ASCII value for 'U'
        JSR $FFD2       ; Print character to screen
        LDA #$4C        ; Load ASCII value for 'L'
        JSR $FFD2       ; Print character to screen
        LDA #$59        ; Load ASCII value for 'Y'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

AUGUST  LDA #$41        ; Load ASCII value for 'A'
        JSR $FFD2       ; Print character to screen
        LDA #$55        ; Load ASCII value for 'U'
        JSR $FFD2       ; Print character to screen
        LDA #$47        ; Load ASCII value for 'G'
        JSR $FFD2       ; Print character to screen
        LDA #$55        ; Load ASCII value for 'U'
        JSR $FFD2       ; Print character to screen
        LDA #$53        ; Load ASCII value for 'S'
        JSR $FFD2       ; Print character to screen
        LDA #$54        ; Load ASCII value for 'T'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

SEPTEMBER LDA #$53       ; Load ASCII value for 'S'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$50        ; Load ASCII value for 'P'
        JSR $FFD2       ; Print character to screen
        LDA #$54        ; Load ASCII value for 'T'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$4D        ; Load ASCII value for 'M'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$52        ; Load ASCII value for 'R'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

OCTOBER LDA #$4F        ; Load ASCII value for 'O'
        JSR $FFD2       ; Print character to screen
        LDA #$43        ; Load ASCII value for 'C'
        JSR $FFD2       ; Print character to screen
        LDA #$54        ; Load ASCII value for 'T'
        JSR $FFD2       ; Print character to screen
        LDA #$4F        ; Load ASCII value for 'O'
        JSR $FFD2       ; Print character to screen
        LDA #$42        ; Load ASCII value for 'B'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$52        ; Load ASCII value for 'R'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

NOVEMBER LDA #$4E       ; Load ASCII value for 'N'
        JSR $FFD2       ; Print character to screen
        LDA #$4F        ; Load ASCII value for 'O'
        JSR $FFD2       ; Print character to screen
        LDA #$56        ; Load ASCII value for 'V'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$4D        ; Load ASCII value for 'M'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$52        ; Load ASCII value for 'R'
        JSR $FFD2       ; Print character to screen
        JMP END         ; Jump to end

DECEMBER LDA #$44       ; Load ASCII value for 'D'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$43        ; Load ASCII value for 'C'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$4D        ; Load ASCII value for 'M'
        JSR $FFD2       ; Print character to screen
        LDA #$42        ; Load ASCII value for 'B'
        JSR $FFD2       ; Print character to screen
        LDA #$45        ; Load ASCII value for 'E'
        JSR $FFD2       ; Print character to screen
        LDA #$52        ; Load ASCII value for 'R'
        JSR $FFD2       ; Print character to screen

END     LDA #$0D        ; Load ASCII value for carriage return
        JSR $FFD2       ; Print carriage return
        LDA #$0A        ; Load ASCII value for line feed
        JSR $FFD2       ; Print line feed
        INX             ; Increment X register
        CPX #12         ; Compare X register with 12 (number of months)
        BNE LOOP        ; Branch to LOOP if not equal
        BRK             ; End program

        .end
