
ORG $0200

LDX #$00   ; Initialize X register to keep track of distance
LDY #$00   ; Initialize Y register to loop through strings
LDZ #$00   ; Initialize Z register to store current character in string 1

LDA STR1,Y ; Load first character from string 1
BEQ DONE   ; If end of string 1 is reached, exit loop
STA Z      ; Store current character in Z register
INC Y      ; Move to next character in string 1

LOOP:
LDA STR2,Y ; Load character from string 2
CMP Z
BEQ CONTINUE ; If characters match, continue to next character
CLC
ADC #$01  ; Increment distance if characters don't match
CONTINUE:
INC Y      ; Move to next character in string 2

LDA STR1,Y ; Load next character from string 1
CMP #$00   ; Check for end of string 1
BEQ DONE
STA Z      ; Store current character in Z register
BRA LOOP

DONE:
STX DISTANCE ; Store distance in memory
BRK

DISTANCE:     .BYTE $00  ; Byte to store distance between strings

STR1:         .BYTE "STRING1"   ; First string
STR2:         .BYTE "STRING2"   ; Second string

ORG $FFFA
DW START
DW $FFFF

ORG $FFFC
DW START

ORG $FC00
START:
JSR $0200
NOP
