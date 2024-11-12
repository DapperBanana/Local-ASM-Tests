
; Grayscale conversion program for 6502 Assembly

; Load image data into memory
LDA $2000  ; Load pixel value
STA $3000  ; Store pixel value in temporary memory location

; Grayscale conversion formula: Gray = 0.299*R + 0.587*G + 0.114*B
LDA $3000  ; Load pixel value
AND #%00000111  ; Mask out the blue component
TAX  ; Transfer pixel value to X register
ASL A  ; Multiply pixel value by 2 (shift left)
ADC $3000  ; Add original pixel value to the result in the A register
LDA $3000  ; Load pixel value
AND #%00111000  ; Mask out the green component
TAX  ; Transfer pixel value to X register
ASL A  ; Multiply pixel value by 2 (shift left)
ADC $3000  ; Add original pixel value to the result in the A register
LDA $3000  ; Load pixel value
LSR A  ; Divide pixel value by 2 (shift right)
TAX  ; Transfer pixel value to X register
ASL A  ; Multiply pixel value by 2 (shift left)
ADC $3000  ; Add original pixel value to the result in the A register
STA $3001  ; Store grayscale pixel value in memory

; Repeat the process for each pixel in the image

; End of program
BRK  ; Break execution
