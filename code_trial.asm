
; 6502 Assembly program to calculate the distance between two points in 3D space

.org $0600    ; Start of program

LDX #0       ; Initialize X register for loop
LDY #0       ; Initialize Y register for loop

; Coordinates of point 1 (x1, y1, z1)
LDA $0700,X  ; Load x1
STA $00      ; Store x1
LDA $0701,X  ; Load y1
STA $01      ; Store y1
LDA $0702,X  ; Load z1
STA $02      ; Store z1

INX          ; Increment X register
INX          ; Increment X register
INX          ; Increment X register

; Coordinates of point 2 (x2, y2, z2)
LDA $0700,X  ; Load x2
STA $03      ; Store x2
LDA $0701,X  ; Load y2
STA $04      ; Store y2
LDA $0702,X  ; Load z2
STA $05      ; Store z2

; Calculate distance between points
LDA $00      ; Load x1
SEC          ; Set carry flag for subtraction
SBC $03      ; Subtract x2
TAX          ; Save result in X register

LDA $01      ; Load y1
SEC          ; Set carry flag for subtraction
SBC $04      ; Subtract y2
TAY          ; Save result in Y register

LDA $02      ; Load z1
SEC          ; Set carry flag for subtraction
SBC $05      ; Subtract z2

TYA          ; Load Y register
CLC          ; Clear carry flag
ADC $00      ; Add x difference squared
TAY          ; Save result in Y register

TYA          ; Load Y register
CLC          ; Clear carry flag
ADC $06      ; Add y difference squared
TAY          ; Save result in Y register

TAX          ; Load X register
CLC
ADC $07      ; Add z difference squared

RTS          ; Return from subroutine

