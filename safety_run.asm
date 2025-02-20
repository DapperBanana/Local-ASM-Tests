
ROM_START equ $c000

.org ROM_START

LDA #0
STA $00          ; Initialize counter for 1000's place
STA $01          ; Initialize counter for 100's place
STA $02          ; Initialize counter for 10's place
STA $03          ; Initialize counter for 1's place

LDA #2000        ; Input decimal number
STA $10
LDA #65
STA $11

LDA $10          ; Copy decimal number to accumulator
CLC
ADC #$00         ; Clear carry flag

LOOP_1000 LDA $00
CMP #3
BEQ LOOP_100

LDA $10
SEC
SBC #1000
CMP #$10
BEQ LOOP_100

LDA $00
CLC
ADC #1
STA $00

BCC LOOP_1000

LOOP_100 LDA $01
CMP #3
BEQ LOOP_10

LDA $10
SEC
SBC #$100
CMP #$10
BEQ LOOP_10

LDA $01
CLC
ADC #1
STA $01

BCC LOOP_100

LOOP_10 LDA $02
CMP #3
BEQ LOOP_1

LDA $10
SEC
SBC #$10
CMP #$1
BEQ LOOP_1

LDA $02
CLC
ADC #1
STA $02

BCC LOOP_10

LOOP_1 LDA $03
CMP #3
BEQ DONE

LDA $10
SEC
SBC #$1
BEQ DONE

LDA $03
CLC
ADC #1
STA $03

BCC LOOP_1

DONE 

LDA $00
CLC
ADC #$48
STA $20
LDA $01
CLC
ADC #$48
STA $21 
LDA $02
CLC
ADC #$48
STA $22
LDA $03
CLC
ADC #$48
STA $23

RTS
