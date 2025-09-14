
.INCLUDE "6502.inc"

; Constants
NUM_DIGITS = 4

          ORG $0200
START:

; Initialize variables
          LDX #0
          STX COUNT
          LDA #$00
          STA SUM

; Prompt user for input number
          LDA #$00
          STA $fb
          LDA #$0C
          JSR $ffd2  ; Output character
          LDA #">"
          JSR $ffd2
          JSR READ_NUM  ; Read input number
          STA NUMBER

; Calculate sum of digits
          LDX #0
CALC_SUM:
          LDA NUMBER
          ASL
          STA TEMP
          LDA TEMP
          ADC SUM
          STA SUM
          LSR
          STA NUMBER
          DEX
          BNE CALC_SUM

; Check if number is a perfect digital invariant
          CMP SUM
          BEQ PERFECT
          JMP NOT_PERFECT

PERFECT:
          LDA #$0D
          JSR $ffd2
          LDA #$0A
          JSR $ffd2
          LDA #0
          JSR $ffd2
          LDA #"Y"
          JSR $ffd2
          JMP END

NOT_PERFECT:
          LDA #$0D
          JSR $ffd2
          LDA #$0A
          JSR $ffd2
          LDA #0
          JSR $ffd2
          LDA #"N"
          JSR $ffd2

END:
          BRK

; Subroutine to read a number from the user
READ_NUM:
          LDX $fb
          LDA #$00
GET_CHAR:
          JSR $ffd2 ; Input character
          CMP #0D   ; Check for Enter key
          BEQ DONE
          CMP #8    ; Check for backspace
          BEQ BACKSPACE
          STA $fe
          LDA $fe
          JSR $ffd2 ; Output character
          STA TEMP
          LDA NUMBER
          ASL
          STA NUMBER
          LDA TEMP
          AND #$0F
          ORA NUMBER
          STA NUMBER
          JMP GET_CHAR

BACKSPACE:
          LDA $fe
          JSR $ffd2 ; Output backspace
          LDA $fe
          JSR $ffd2 ; Clear character
          JMP GET_CHAR

DONE:
          RTS

COUNT:
          .BYTE 0
NUMBER:
          .BYTE 0
SUM:
          .BYTE 0
TEMP:
          .BYTE 0

          .ORG $02ff
          .WORD START
