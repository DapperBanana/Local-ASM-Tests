
; Define variables
IMAGE_START = $4000
IMAGE_SIZE = 16*16
BYTE_PER_PIXEL = 1

; Load image data into memory
LDA #IMAGE_START
STA $FE
LDX #IMAGE_SIZE
LDA #BYTE_PER_PIXEL
STA $FF
LDY #0
LOOP:
    LDA IMAGE_START, Y
    JSR GRAYSCALE
    STA IMAGE_START, Y
    INY
    CPY #IMAGE_SIZE
    BNE LOOP

; Gray scale conversion subroutine
GRAYSCALE:
    TAX
    AND #$0F ; Keep the lower 4 bits (mask out the higher 4 bits)
    LDA #$10
    JSR DIVIDE
    TAX
    ORA X
    STA 0
    RTS

; Divide subroutine (divides A by X)
DIVIDE:
    LSR
    CMP X
    BCC RESTORE
    SBC X
    INC 0
    JMP DIVIDE
RESTORE:
    ADC X
    RTS
