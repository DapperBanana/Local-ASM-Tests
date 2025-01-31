
; Check if a given string is a valid credit card number

CARD_NUMBER_LENGTH equ 16
CARD_NUMBER_OFFSET equ $00
CARD_NUMBER_BUFFER equ $40

LDA #$00
STA CARD_NUMBER_OFFSET
LDX CARD_NUMBER_OFFSET

CheckCardNumber:
    LDA CARD_NUMBER_BUFFER, X    ; Load character from the buffer
    BEQ CardNumberIsValid        ; Check if end of string
    
    CMP #$30                    ; Check if character is a digit
    BMI CardNumberNotValid

    CMP #$39
    BPL NextCharacter

CardNumberNotValid:
    LDA #$00
    RTS

NextCharacter:
    INX
    CPX CARD_NUMBER_LENGTH      ; Check if end of card number
    BNE CheckCardNumber
    
CardNumberIsValid:
    LDA #$01
    RTS
