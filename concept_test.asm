
ORG $0600
START:
    LDX #$0A   ; loop counter for 10
    JSR CONVERT_TO_ROMAN        ; convert to Roman numeral
    STX LOOP_COUNT

CHECK_LOOP:
    CPX #$00          ; check if loop counter reaches 0
    BEQ DONE          ; if it reaches 0, exit

    JSR PRINT_NUMERAL     ; print the Roman numeral
    DEC LOOP_COUNT        ; decrement loop counter
    BNE CHECK_LOOP

DONE:
    BRK

CONVERT_TO_ROMAN:
    LDA #$01       ; start with 'I'
    STA ROMAN_PTR  ; initialize pointer to Roman numeral lookup table

    LDX #$01       ; initialize digit position (units)
CONVERT_LOOP:
    LDA VALUE,X         ; load digit value
    BEQ END_CONVERT     ; if digit is 0, exit conversion

    JSR DIGIT_TO_ROMAN   ; convert digit to Roman numeral
    STA ROMAN_OUTPUT,X   ; store converted Roman numeral
    INX                  ; increment digit position
    BNE CONVERT_LOOP     ; loop until conversion is done

END_CONVERT:
    RTS

PRINT_NUMERAL:
    LDA ROMAN_OUTPUT,X    ; load Roman numeral for printing
    JSR PRINT_CHARACTER   ; print the character
    RTS

PRINT_CHARACTER:
    ;Code to print the character
    RTS

VALUE:
    .BYTE $00, $01, $02, $03, $04, $05, $06, $07, $08, $09

ROMAN_TABLE:
    .BYTE 'I', 'V', 'X', 'L', 'C', 'D', 'M'

ROMAN_PTR:
    .BYTE

ROMAN_OUTPUT:
    .BYTE $00, $00

DIGIT_TO_ROMAN:
    LDA ROMAN_PTR    
    CLC
    ADC VALUE,X
    STA ROMAN_PTR
    AND #$07
    ADC ROMAN_TABLE,X
    RTS

LOOP_COUNT:
    .BYTE

END:
    .BYTE $00
