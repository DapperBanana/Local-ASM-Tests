
; Load image data address into X register
LDX #$00       ; Start at address $0000
LDA $2000,X    ; Load pixel value into accumulator

; Convert RGB to Grayscale using the formula: Gray = 0.299*R + 0.587*G + 0.114*B
; Get red component
STA $3000,X    ; Store the grayscale value back at the same address
INY            ; Increment Y
LDA $2000,X    ; Load next pixel
STA $3000,X
INY
LDA $2000,X
STA $3000,X

; Repeat for the entire image by incrementing X register and continuing the loop

; Halt the program
BRK
