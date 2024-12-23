
; Area of a Triangle Calculator

.org $0200        ; Define program start address

LDX #3           ; Load X register with number of sides (3)
LDA SIDES,X      ; Load the value of the third side into the A register
STA C             ; Store the value of the third side into C

DEX              ; Decrement X to load the second side
LDA SIDES,X      ; Load the value of the second side into the A register
STA B             ; Store the value of the second side into B

DEX              ; Decrement X to load the first side
LDA SIDES,X      ; Load the value of the first side into the A register
STA A             ; Store the value of the first side into A

; Calculate the semiperimeter of the triangle
LDA A
CLC
ADC B
CLC
ADC C
LSR
STA S

; Calculate the area of the triangle using Heron's formula
LDA S
SEC
SBC A
SEC
SBC B
SEC
SBC C
SEC
SBC A
SEC
SBC B
SEC
SBC C
LSR
STA AREA

JMP $FFD2       ; End of program

SIDES    .BYTE 10, 12, 14   ; Define the sides of the triangle
A        .BYTE 0            ; Define A register for first side
B        .BYTE 0            ; Define B register for second side
C        .BYTE 0            ; Define C register for third side
S        .BYTE 0            ; Define semiperimeter register
AREA     .BYTE 0            ; Define area register

