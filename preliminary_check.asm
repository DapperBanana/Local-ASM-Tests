
        .org $0600

START   LDX #$00        ; Initialize index register to 0
        LDY #$00        ; Initialize Y register for keeping track of number of digits
        LDA #$00        ; Initialize accumulator to 0
READ    LDA $0200,X     ; Load character from input string
        BEQ DONE        ; If end of string reached, exit loop
        CMP #'0'        ; Check if character is a digit
        BCC NON_DIGIT   ; If not a digit, skip to NON_DIGIT
        CMP #'9'
        BCS NON_DIGIT

        INC Y           ; Increment count of digits
        CLC
        ADC #$00        ; Convert ASCII digit to integer
        CMP #'0'
        BCC NON_DIGIT
        CMP #'9'
        BCS NON_DIGIT
        BMI NON_DIGIT
        BNE NEXT

NON_DIGIT
        LDX #$00        ; Reset index if non-digit found
        LDY #$00
NEXT    INX             ; Move to next character
        JMP READ

DONE    CPY #$10        ; Check if 10 digits were read
        BNE INVALID     ; If not, ISBN is invalid

        LDA #$50        ; Initialize accumulator to 50
        LDX #$09        ; Initialize index to 9 for weighted sum calculation
        LDY #$01        ; Initialize index to 1 for digit position

SUM_LOOP
        LDA $0200,X     ; Load digit from input string
        SEC
        SBC #'0'        ; Convert ASCII digit to integer
        STA TMP         ; Store digit for later use
        CLC
        ADC Y           ; Add digit position to weighted sum
        STA TMP         ; Store result
        DEY
        BPL SKIP_ADD    ; If not at the last digit, skip adding to sum
        LDA TMP         ; Load final value of weighted sum
        CMP #$00        ; Check if sum is divisible by 11
        BNE INVALID     ; If not, ISBN is invalid

        LDA #$48        ; ASCII value for 'Y'
        STA $0230       ; Store 'Y' in output string
        STA $0203       ; Store 'Y' in output string
        JMP END

INVALID
        LDA #$4E        ; ASCII value for 'N'
        STA $0230       ; Store 'N' in output string
        STA $0203       ; Store 'N' in output string

END     BRK             ; End program

TMP     .byte $00
