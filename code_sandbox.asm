
ORG $0200

BASE_AREA EQU $0200
HEIGHT EQU $0204
PYRAMID_AREA EQU $0208

LDA BASE_AREA     ; Load base area into accumulator
STA $00           ; Store base area in memory location $00

LDA HEIGHT        ; Load height into accumulator
STA $01           ; Store height in memory location $01

LDA $00           ; Load base area from memory location $00
STA $02           ; Store base area in memory location $02

LDA $01           ; Load height from memory location $01
STA $03           ; Store height in memory location $03

LDX $02           ; Load base area into X register
LDY $03           ; Load height into Y register

JSR MULTIPLY      ; Call subroutine to calculate base area times height

STA $04           ; Store result in memory location $04

LDA $04           ; Load result from memory location $04
LSR               ; Divide by 2
STA $05           ; Store result in memory location $05

LDA $05           ; Load final result from memory location $05
STA PYRAMID_AREA  ; Store final result in memory location PYRAMID_AREA

RTS

MULTIPLY:
  LDX #0          ; Clear X register
  STY $06         ; Store height in memory location $06
  
LOOP:
  CLC             ; Clear carry flag
  LDA $06         ; Load height from memory location $06
  ADC $04         ; Add base area times height
  STA $07         ; Store result in memory location $07
  LDX $04         ; Load base area into X register
  DEY             ; Decrement Y register
  BNE LOOP        ; Branch if Y register is not zero
  LDA $07         ; Load final result from memory location $07
  RTS

END
