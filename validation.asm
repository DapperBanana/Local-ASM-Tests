
; Load image data into memory
LDA #<imageData ; Low byte of image data
LDX #>imageData ; High byte of image data
LDY #$00        ; Initialize Y register

loadLoop:
    LDA (X), Y   ; Load pixel data
    STA $0200, Y ; Store pixel data in memory
    INY          ; Increment Y register
    BNE loadLoop ; Continue loading until end of image

; Convert image to grayscale
LDY #$00         ; Reset Y register

grayLoop:
    LDA $0200, Y  ; Load pixel data
    AND #$E0      ; Mask out lower 3 bits
    LSR           ; Shift right 1 bit
    AND #$1C      ; Mask out higher 5 bits
    ORA           ; Combine masked bits
    STA $0300, Y  ; Store grayscale pixel data in memory
    INY           ; Increment Y register
    CPY #$FF      ; Check if end of image reached
    BNE grayLoop  ; Continue grayscale conversion

; End of program
BRK

; Image data
imageData:
.byte $FF, $AA, $8C, $00, $4F, $B2, $79, $21
