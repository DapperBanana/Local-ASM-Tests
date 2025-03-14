
    .org $0200

START
    LDX #0 ; Initialize index to 0
    LDA NUMBER ; Load number to be converted
    CMP #$3D ; Compare to 61 (Largest number that can be represented with Roman numerals)
    BCC NOT_SUPPORTED ; Branch if number is not supported
    STA RESULT ; Store original number in result variable
    ; Check how many times 10 can be subtracted from the number
DIVIDE_BY_10
    LDA RESULT
    SEC
    SBC #$0A ; Subtract 10
    BCC NOT_DIVISIBLE_BY_10 ; Branch if not divisible by 10
    INX ; Increment index
    STA RESULT ; Store new number
    JMP DIVIDE_BY_10

NOT_DIVISIBLE_BY_10
    ; Check how many times 5 can be subtracted from the number
    LDA RESULT
    SEC
    SBC #$05 ; Subtract 5
    BCC NOT_DIVISIBLE_BY_5 ; Branch if not divisible by 5
    INX ; Increment index
    STA RESULT ; Store new number
    JMP NOT_DIVISIBLE_BY_10

NOT_DIVISIBLE_BY_5
    ; Check how many times 1 can be subtracted from the number
    LDA RESULT
    SEC
    SBC #$01 ; Subtract 1
    BCC FINISH ; Branch if number is now 0
    INX ; Increment index
    STA RESULT ; Store new number
    JMP NOT_DIVISIBLE_BY_5

NOT_SUPPORTED
    LDX #0 ; Reset index to 0
    LDA #$FF ; Set result to -1 indicating not supported
    STA RESULT

FINISH
    LDA INDEX ; Load index
    STA ROMAN_TABLE,X ; Store corresponding Roman numeral in result string
    INX
    LDA #$00
    STA ROMAN_TABLE,X ; Terminate string with null character

    STA $FD8F ; Output result to screen

    RTS

NUMBER .byte $3D
RESULT .byte $00
INDEX .byte $00

ROMAN_TABLE
    .byte 'LXIX'

    .end
