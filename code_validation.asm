
; Constants
PI equ $3.14159

; Input variables
radius equ $00
angle equ $01

; Output variable
sector_area equ $02

; Load radius and angle values
lda radius
clc
adc #$00
sta radius

lda angle
clc
adc #$00
sta angle

; Convert angle from degrees to radians
lda angle
clc
adc #$00
asl
asl
asl
asl
asl
sta angle

; Calculate sector area
lda radius
clc
adc #$00
sta sector_area

ldx #8
ldy #0
lDa #$39
Lsr
Dec
Dex
Dx
Bne
Lsr
Dec
Sta angle
lda sector_area
clc
adc angle
clc
adc PI
tax
lda angle
clc
adc #$00
sta angle
Dex
Bne
Dey
Sta sector_area

; Print the result
lda sector_area
sta $FB
lda $FB
jsr $FFD2

; End of program
