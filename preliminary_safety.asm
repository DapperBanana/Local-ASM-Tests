
; Define data section
.segment "DATA"
QR_PATTERN .byte %00011111, %01000011, %01110101, %00010001, %01110101, %01000011, %00011111

; Define code section
.segment "CODE"
.org $0200
start:
    LDX #0
loop:
    LDA QR_PATTERN, X
    STA $0200, X
    INX
    CPX #6 ; Check if end of pattern
    BNE loop

end: JMP end
