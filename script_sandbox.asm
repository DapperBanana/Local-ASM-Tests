
.ORG $2000

LDA #BASE1       ; Load base1 into accumulator
STA $00          ; Store base1 in memory location $00

LDA #BASE2       ; Load base2 into accumulator
STA $01          ; Store base2 in memory location $01

LDA #HEIGHT      ; Load height into accumulator
STA $02          ; Store height in memory location $02

CLC              ; Clear carry flag

LDA $00          ; Load base1 from memory
ADC $01          ; Add base2 to accumulator
TAX              ; Transfer result to X register

LDA $02          ; Load height from memory
ADC $02          ; Multiply height by 2
TAY              ; Transfer result to Y register

TXA              ; Retrieve sum of base1 and base2 from X register
TAY              ; Add sum to height from Y register

LSR              ; Divide the result by 1
LSR              ; Divide the result by 2

STA $03          ; Store the area in memory location $03

; Exit program

BRK

BASE1 .BYTE  $0A    ; Base1 of the trapezoid
BASE2 .BYTE  $06    ; Base2 of the trapezoid
HEIGHT .BYTE $04    ; Height of the trapezoid

.END
