
; Grayscale conversion program for 6502 Assembly

; Memory locations
IMAGE_START = $2000		; Start of image data
IMAGE_WIDTH = 64		; Width of image in pixels
IMAGE_HEIGHT = 64		; Height of image in pixels

; Load image data into memory
LDX #0
LDY #0
LDA #<IMAGE_DATA
STA IMAGE_START,X
INY
CPY #IMAGE_HEIGHT
BNE LDA_LOOP
INC X
LDX #0
INX
LDA #<IMAGE_DATA
BEQ LDA_LOOP

; Grayscale conversion loop
LDA IMAGE_START,X
STA $FF00	; Store original pixel value
LSR A		; Shift right to get grayscale value
LSR A
LSR A
STA IMAGE_START,X	; Store grayscale pixel value
INX
CPX #(IMAGE_WIDTH*IMAGE_HEIGHT)
BNE GRAYSCALE_LOOP

; Done
BRK

; Image data
IMAGE_DATA:
.byte $FF, $A8, $15, $3C, $9F, $78, $57, $EE
.byte $00, $FF, $0A, $15, $66, $99, $AA, $FF
.byte $F0, $0F, $00, $FF, $88, $77, $11, $22
.byte $11, $22, $44, $55, $FF, $33, $66, $55
.byte $AA, $BB, $CC, $DD, $EE, $FF, $00, $22
.byte $FF, $AA, $55, $00, $55, $AA, $FF, $00
.byte $0F, $1E, $2D, $3C, $4B, $5A, $69, $78
.byte $11, $33, $55, $77, $99, $BB, $DD, $FF
