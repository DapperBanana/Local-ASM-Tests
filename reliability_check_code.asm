
; Initialize program

LDA #$00 ; Clear accumulator
STA $6000 ; Set start address for image memory

LDA #$00 ; Set X coordinate to 0
LDX #$00 ; Set Y coordinate to 0

loop:
; Generate random pixel color
LDA #*$05 ; Load color value (0-255) into accumulator
STA $6000,X ; Store color value at current memory address

INX ; Increment X coordinate
CPX #$80 ; Check if reached end of row
BNE loop ; If not, continue to next pixel
LDX #$00 ; Reset X coordinate to 0

INY ; Increment Y coordinate
CPY #$50 ; Check if reached end of image
BNE loop ; If not, continue to next row

RTS ; End program
