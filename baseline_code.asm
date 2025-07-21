
LDX #BASE_LENGTH
LDY #HEIGHT
LDA #0
STA AREA ; Initialize AREA to 0

; Calculate the area of an equilateral triangle
CLC
LDA BASE_LENGTH
ADC BASE_LENGTH
ADC BASE_LENGTH
STA TEMP ; TEMP = 3*BASE_LENGTH

; Calculate the area of a triangle with the base and height given
LDA TEMP
CLC
ADC HEIGHT
TAX ; X = 3*BASE_LENGTH + HEIGHT

; Calculate the final area of the tetrahedron
LDA TEMP
CLC
ADC X
STA AREA ; AREA = TEMP + X

DONE: 
  NOP ; Do nothing, program completed
  
BASE_LENGTH: .BYTE $0A ; Base length of the tetrahedron
HEIGHT: .BYTE $05 ; Height of the tetrahedron
TEMP: .BYTE $00 ; Temporary storage variable
AREA: .BYTE $00 ; Final area of the tetrahedron
