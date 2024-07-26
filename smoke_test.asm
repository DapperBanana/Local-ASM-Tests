
LDA #$00  ; Clear accumulator
STA $01   ; Initialize index register

LOOP:
LDA IMAGE_DATA, X   ; Load pixel value
LDA IMAGE_DATA, X   ; Load pixel value
LDA IMAGE_DATA, X   ; Load pixel value

; Grayscale conversion algorithm
LSR A        ; divide by 2
AND #$F8     ; clear lowest 3 bits
PHA          ; save result on stack
LSR A        ; divide by 2
AND #$F8     ; clear lowest 3 bits
ADC $00      ; add two halfs
LSR A        ; shift back

STA IMAGE_DATA, X   ; Store converted pixel value

INX        ; increment index
CPX #$FF   ; check if end of data
BNE LOOP   ; if not, loop back

DONE:
BRK   ; End program

IMAGE_DATA:
; Actual image data goes here
.byte $FF, $AA, $55, $00
