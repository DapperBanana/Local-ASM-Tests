
; 6502 Assembly program to calculate the area of a trapezoidal prism

      .org    $8000    ; Load program at address $8000

start:
      ; input the values of the bases and height of the trapezoidal prism
      LDA     #BASE1
      STA     BASE1
      LDA     #BASE2
      STA     BASE2
      LDA     #HEIGHT
      STA     HEIGHT

      ; calculate the area of the trapezoidal prism
      LDA     BASE1
      STA     AREA
      LDA     BASE2
      CLC
      ADC     AREA
      STA     AREA
      LDA     HEIGHT
      CLC
      ADC     AREA
      STA     AREA
      ASL
      TAX
      LDA     BASE1
      CLC
      ADC     BASE2
      TAX
      STA     BASE1
      LDA     AREA
      TAX
      STA     AREA
      LDA     HEIGHT
      TAX
      STA     HEIGHT
      JSR     mul8

      ; print the result
      LDA     AREA
      STA     ($400)
      LDA     AREA+1
      STA     ($401)

end:
      BRK

mul8:
      LDA    	0
      STA    	CARRY
loop:
      LSR    	HEIGHT
      BCC    	skip
      CLC
      ADC    	BASE1
skip:
      ROR    	BASE1
      ROR    	BASE2
      DEC    	X
      BNE    	loop
      RTS

      .byte   BASE1, BASE2, HEIGHT, AREA, CARRY

BASE1:  .byte   6     ; Base 1 of trapezoidal prism
BASE2:  .byte   8     ; Base 2 of trapezoidal prism
HEIGHT: .byte   5     ; Height of trapezoidal prism
AREA:   .byte   0     ; Area of the trapezoidal prism
CARRY:  .byte   0     ; Carry flag
