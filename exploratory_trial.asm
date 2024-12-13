
; Grayscale Conversion Program

LDA #$00 ; Load accumulator with 0
STA $2000 ; Store accumulator in memory address $2000

LDX #$00 ; Load X register with 0

loop:
LDA $4000, X ; Load pixel value from image data at address $4000
AND #$E0 ; Mask the lower 3 bits for blue color channel
LSR ; Shift right to get the blue value
AND #$E0 ; Mask the lower 3 bits for green color channel
LSR ; Shift right to get the green value
AND #$E0 ; Mask the lower 3 bits for red color channel
LSR ; Shift right to get the red value
CLC ; Clear carry flag for addition
ADC $2000 ; Add the red, green, and blue values together
LSR ; Divide by 3 for grayscale conversion
STA $5000, X ; Store grayscale pixel value at address $5000

INX ; Increment X register
CPX #$FF ; Compare X register with 255
BNE loop ; If not equal, loop back to load next pixel

BRK ; Break execution

; Image Data
.org $4000
.byte $FF, $AA, $55, $00, $FF, $AA, $55, $00 ; Sample image data

; Grayscale Image Data
.org $5000

