
; Basic file compression algorithm in 6502 Assembly

; Constants
CR = $0D ; Carriage return character
LF = $0A ; Line feed character

; Variables
SourceAddr = $2000 ; Source data address
DestAddr = $3000 ; Compressed data address
TempData = $4000 ; Temporary data space

; Main program
START:
    LDA #$00 ; Initialize counter
    STA Counter

    LDX #$00 ; Initialize index
    STX SourceAddr
    STX DestAddr
    STX TempData

LOOP:
    ; Load byte from source data
    LDA (SourceAddr),X
    BEQ COMPRESS ; If end of data, go to compression

    ; Check if byte is repeated
    CMP (SourceAddr),X+1 
    BNE WRITE_BYTE ; If not repeated, write byte as-is
    INC Counter ; Increase counter

REPEAT_LOOP:
    ; Repeat until byte is not repeated
    CPX #$FF
    BEQ COMPRESS ; If counter reached max value, go to compression
    LDA (SourceAddr),X+
    CMP (SourceAddr),X
    BEQ REPEAT_LOOP
    CMP (SourceAddr),X+1
    BEQ REPEAT_LOOP

COMPRESS:
    ; Write compressed data
    STA TempData
    LDA Counter
    STA TempData+1
    LDA TempData
    STA (DestAddr),Y
    LDA TempData+1
    STA (DestAddr),Y+1

    ; Increase destination address
    CLC
    ADC #$02
    STA DestAddr

    ; Reset counter
    LDA #$00
    STA Counter

    ; Skip carriage return and line feed characters
    CMP CR
    BEQ LOOP
    CMP LF
    BEQ LOOP

WRITE_BYTE:
    ; Write uncompressed byte
    STA (DestAddr),Y

    ; Increase destination address
    CLC
    ADC #$01
    STA DestAddr

    JMP LOOP

Counter:
    .BYTE $00

    .ORG $FFFC
    .WORD START
