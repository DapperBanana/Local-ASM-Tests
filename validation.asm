
; TRAPEZOIDAL PRISM AREA CALCULATOR

START LDX #BASE1   ; Load the value of BASE1 into X register
LDY #BASE2        ; Load the value of BASE2 into Y register
LDA #HEIGHT         ; Load the value of HEIGHT into Accumulator

; Calculate the average of BASE1 and BASE2
LDA #$00            ; Clear Accumulator
CLC
ADC X
ADC Y
LSR                 ; Divide by 2
STA AVERAGE

; Calculate the area of trapezoid base
LDA AVERAGE
LDX HEIGHT
STX TEMP
LDX BASE1
LDY BASE2
SEC
ADC Y
TAY
LDA TEMP
ADC Y
TAX
JSR MULTIPLY
STA AREA

; Calculate the area of the two trapezoidal faces
LDA BASE1
STX SIDE
JSR MULTIPLY
STA TEMP_AREA

LDA BASE2
STX SIDE
JSR MULTIPLY
SEC
SBC TEMP_AREA
STA TEMP_AREA

; Add the three areas to calculate the total area
LDA AREA
ADC TEMP_AREA
STA TOTAL_AREA

BRK          ; End program execution

; Subroutine to multiply two numbers
MULTIPLY LDX #$00
CMD X
LSR
ROR A
DEX
BNE CMD X
RTS

BASE1 .BYTE $04     ; Example value for BASE1
BASE2 .BYTE $06     ; Example value for BASE2
HEIGHT .BYTE $03    ; Example value for HEIGHT

TEMP .BYTE $00
AVERAGE .BYTE $00
SIDE .BYTE $00
AREA .BYTE $00
TEMP_AREA .BYTE $00
TOTAL_AREA .BYTE $00

