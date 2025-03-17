
; Calculate the area of a pentagon
;
; Input:
; - Radius of the circle inscribed in the pentagon (r) - stored at memory location $00 (low byte) and $01 (high byte)
;
; Output:
; - Area of the pentagon - stored at memory location $02 (low byte) and $03 (high byte)

    .org $0600

main:
    lda $00     ; Load the low byte of the radius
    sta $04     ; Store it at memory location $04
    lda $01     ; Load the high byte of the radius
    sta $05     ; Store it at memory location $05

    jsr calc_side_length ; Call subroutine to calculate the side length of the pentagon

    ; Calculate the area of the pentagon
    lda $04     ; Load the low byte of the side length
    clc
    asl         ; Multiply by 2
    sta $06     ; Store the result at memory location $06

    lda $04     ; Load the low byte of the side length
    clc
    asl         ; Multiply by 2
    clc
    asl         ; Multiply by 4
    sta $08     ; Store the result at memory location $08

    lda $06     ; Load the low byte of the multiplied side length
    clc
    asl         ; Multiply by 2
    clc
    asl         ; Multiply by 4
    clc
    asl         ; Multiply by 8
    sta $0A     ; Store the result at memory location $0A

    lda $08     ; Load the low byte of the multiplied side length
    clc
    asl         ; Multiply by 2
    clc
    asl         ; Multiply by 4
    clc
    asl         ; Multiply by 8
    ror         ; Divide by 16
    sta $08     ; Store the result at memory location $08

    lda $0A     ; Load the low byte of the multiplied side length
    clc
    asl         ; Multiply by 2
    clc
    asl         ; Multiply by 4
    clc
    asl         ; Multiply by 8
    ror         ; Divide by 16
    ror         ; Divide by 32
    sta $0A     ; Store the result at memory location $0A

    lda $08     ; Load the low byte of the multiplied side length
    clc
    adc $0A     ; Add the low byte of the multiplied side length together
    sta $08     ; Store the result at memory location $08

    lda $04     ; Load the low byte of the side length
    clc
    asl         ; Multiply by 2
    asl         ; Multiply by 4
    asl         ; Multiply by 8
    asl         ; Multiply by 16
    ror         ; Divide by 32
    sta $0C     ; Store the result at memory location $0C

    lda $08     ; Load the low byte of the multiplied side length
    clc
    adc $0C     ; Add the low byte of the multiplied side length together
    sta $08     ; Store the result at memory location $08

    lda $06     ; Load the low byte of the multiplied side length
    clc
    asl         ; Multiply by 2
    asl         ; Multiply by 4
    asl         ; Multiply by 8
    ror         ; Divide by 16
    sta $0A     ; Store the result at memory location $0A

    lda $08     ; Load the low byte of the multiplied side length
    clc
    adc $0A     ; Add the low byte of the multiplied side length together
    sta $08     ; Store the result at memory location $08

    lda $08     ; Load the low byte of the multiplied side length
    clc
    asl         ; Multiply by 2
    clc
    asl         ; Multiply by 4
    sta $08     ; Store the result at memory location $08

    lda $08     ; Load the low byte of the multiplied side length
    ldx $08     ; Load the high byte of the multiplied side length
    jmp $084E   ; Multiply by -16

calc_side_length:
    lda $04     ; Load the low byte of the radius
    clc
    ldx $04     ; Load the high byte of the radius
    clc
    asl         ; Multiply by 2
    sta $04     ; Store the result at memory location $04

    lda $04     ; Load the low byte of the multiplied radius
    clc
    ldx $04     ; Load the high byte of the multiplied radius
    clc
    asl         ; Multiply by 2
    txa
    clc
    adc $04     ; Add the low byte of the multiplied radius together
    sta $04     ; Store the result at memory location $04

    lda $04     ; Load the low byte of the multiplied radius
    clc
    ldx $04     ; Load the high byte of the multiplied radius
    clc
    asl         ; Multiply by 2

    rts         ; Return from subroutine
