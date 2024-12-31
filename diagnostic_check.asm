
    .org $0800

START:
    LDA #$00
    STA SUM ; initialize sum to 0
    
    LDX #$08 ; load file name address
NEXT_CHAR:
    LDA (X),Y ; load character from file name
    BEQ OPEN_FILE ; if end of file name, open file
    STA TEMP ; store character in temporary variable
    INX
    JMP NEXT_CHAR ; load next character

OPEN_FILE:
    ; open file code here

READ_DATA:
    LDA $B500 ; read character from file
    BEQ END_OF_FILE ; if end of file, exit loop
    CMP #$30 ; compare with ASCII '0'
    BCC SKIP_NON_NUMERIC ; if character is not numeric, skip it
    CMP #$39 ; compare with ASCII '9'
    BCS SKIP_NON_NUMERIC ; if character is not numeric, skip it
    CLC
    ADC #$D0 ; convert ASCII to decimal
    STA TEMP ; store numeric value in temporary variable
    LDA SUM
    CLC
    ADC TEMP ; add numeric value to sum
    STA SUM ; store sum in memory
    JMP READ_DATA ; read next character
    
SKIP_NON_NUMERIC:
    JMP READ_DATA ; skip to next character
    
END_OF_FILE:
    ; close file code here
    
    BRK ; end program

SUM:
    .byte $00 ; sum of numbers
TEMP:
    .byte $00 ; temporary storage variable

; file name placeholder
    .byte "DATA.TXT", $00

    .end
