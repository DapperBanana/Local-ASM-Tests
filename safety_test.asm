
START   LDX #0         ; Initialize index register X to 0
        LDA MESSAGE,X ; Load the English message into the accumulator
        BEQ DONE       ; If end of message, exit program
        JSR TRANSLATE  ; Translate the English word into Spanish
        STA $D000,X    ; Store the translated word in memory
        INX            ; Increment index register
        JMP START      ; Continue to next word

TRANSLATE CMP #$20      ; Compare the English word to space character
        BEQ DONE        ; If space character, return without translation
        CMP #$48        ; Compare the English word to "H"
        BEQ HELLO       ; If "H", translate to "Hola"
        CMP #$57        ; Compare the English word to "W"
        BEQ WORLD       ; If "W", translate to "Mundo"
        JMP DONE        ; If no match, return without translation

HELLO   LDA #$H4        ; Load "H" character in Spanish
        STA ($D000),X  ; Store translated character in memory
        INX             ; Increment index register
        LDA #$6F        ; Load "o" character in Spanish
        STA ($D000),X   ; Store translated character in memory
        INX             ; Increment index register
        LDA #$6C        ; Load "l" character in Spanish
        STA ($D000),X   ; Store translated character in memory
        INX             ; Increment index register
        LDA #$61        ; Load "a" character in Spanish
        STA ($D000),X   ; Store translated character in memory
        RTS             ; Return from subroutine

WORLD   LDA #$4D        ; Load "M" character in Spanish
        STA ($D000),X  ; Store translated character in memory
        INX             ; Increment index register
        LDA #$75        ; Load "u" character in Spanish
        STA ($D000),X   ; Store translated character in memory
        INX             ; Increment index register
        LDA #$6E        ; Load "n" character in Spanish
        STA ($D000),X   ; Store translated character in memory
        INX             ; Increment index register
        LDA #$64        ; Load "d" character in Spanish
        STA ($D000),X   ; Store translated character in memory
        INX             ; Increment index register
        RTS             ; Return from subroutine

DONE    BRK             ; Exit program

MESSAGE .BYTE "HELLO WORLD", $00 ; English message to be translated
