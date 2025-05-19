
; Check if a given string is a valid credit card number
;
; Input:
; - The string is stored in memory starting at the address given by STR_ADDR
; - The length of the string is given by STR_LEN
;
; Output:
; - A message is displayed on the screen indicating if the string is a valid credit card number or not

        .org $0200

STR_ADDR = $0200     ; Address where the string is stored
STR_LEN = 16         ; Maximum length of the string

START:
        LDX #STR_LEN           ; Load the maximum length of the string
        LDY #STR_ADDR          ; Load the address of the string

LOOP:
        LDA (Y),X              ; Load the character from memory
        CMP #$30               ; Check if the character is a digit (0-9)
        BCC INVALID            ; If not, jump to the invalid message
        CMP #$39
        BCS INVALID
        DEX
        BPL LOOP               ; Loop until all characters are checked

        JSR LuhnAlgorithm      ; Verify the Luhn Algorithm to check if it is a valid credit card number

VALID:
        LDX #MSG_VALID         ; Load the valid message
        JSR PRINT_MSG          ; Display the valid message
        BRK

INVALID:
        LDX #MSG_INVALID       ; Load the invalid message
        JSR PRINT_MSG          ; Display the invalid message
        BRK

; Function to verify the Luhn Algorithm for credit card validation
; Input:
; - STR_ADDR: Address of the string
; - STR_LEN: Length of the string
; Output:
; - Carry flag is set if the credit card number is valid

LuhnAlgorithm:
        SEC                     ; Initialize the sum
        LDX #STR_LEN            ; Load the maximum length of the string
        LDY #STR_ADDR           ; Load the address of the string

LOOP_LUHN:
        LDA (Y),X               ; Load the character from memory
        CLC
        ADC #$30                ; Convert the ASCII digit to binary
        CMP #$3A
        BCS INVALID_LUHN        ; If not a valid ASCII digit, jump to invalid
        ASL                     ; Double the value
        BCC SKIP_ADD            ; If the carry is not set, skip the addition
        SBC #$0A                ; Subtract 9 from the result if it is greater than 9
SKIP_ADD:
        CLC
        ADC A                   ; Add the value to the sum
        BCC NEXT_CHAR           ; If the carry is not set, skip to next character

        SEC
        SBC #$00                ; Subtract 10 when carry is set
NEXT_CHAR:
        DEX
        BPL LOOP_LUHN           ; Loop until all characters are checked

        BNE INVALID_LUHN        ; If the sum is not a multiple of 10, jump to invalid
        CLC
        RTS

INVALID_LUHN:
        SEC
        RTS

PRINT_MSG:
        LDA #$02                ; Print message to screen
        JSR $FFD2
        RTS

MSG_VALID:
        .text "Valid Credit Card Number", $00

MSG_INVALID:
        .text "Invalid Credit Card Number", $00

        .end
