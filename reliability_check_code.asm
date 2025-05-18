
START:
    LDX #0              ; Initialize index register
    LDA INPUT,X         ; Load first character of input string
    BEQ DONE            ; If first character is null, exit loop
CHECK_DIGIT:
    CMP #'0'            ; Check if character is a digit
    BCC NOT_DIGIT       ; If not a digit, skip processing
    CMP #'9'
    BCS NOT_DIGIT

    JSR CONVERT_TO_NUM  ; Convert ASCII character to numeric value

    STA TEMP            ; Store numeric value in TEMP
    LDA CARD_NUMBER,X   ; Load digit from credit card number
    CLC
    ADC TEMP            ; Add the digit to the running total
    STA CARD_NUMBER,X

    INX                 ; Increment index
    LDA INPUT,X         ; Load next character
    BNE CHECK_DIGIT     ; If not null, continue processing

CHECK_SUM:
    LDX #15             ; Start checking from last digit
    LDA CARD_NUMBER,X   ; Load last digit
    ASL
    CMP CHECKSUM        ; Check if digit is greater than 9
    BCC VALID          ; Valid if less than 9, invalid otherwise

INVALID:
    LDA #0              ; Invalid credit card number
    BRA DONE

VALID:
    LDA #1              ; Valid credit card number

DONE:
    RTS

NOT_DIGIT:
    INX                 ; Skip non-numeric characters
    LDA INPUT,X         ; Load next character
    BNE CHECK_DIGIT     ; If not null, continue processing

CONVERT_TO_NUM:
    SEC
    SBC #'0'            ; Convert ASCII to numeric value
    RTS

INPUT:
    .BYTE '4','5','7','8','9','1','0','0','1','2','3','4','5','6','7',0
CARD_NUMBER:
    .BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
CHECKSUM:
    .BYTE $0A

TEMP:
    .BYTE $00
