
    lda #5          ; Load the number of sides of the pentagon
    sta sidesCount  ; Store the number of sides
    lda #10         ; Load the length of one side of the pentagon
    sta sideLength  ; Store the length of one side
    lda #15         ; Load the height of the prism
    sta height      ; Store the height

    ; Calculate the area of one face of the pentagonal prism
    lda sideLength
    sta base
    lda height
    sta prismHeight
    lda #$00
    sta totalArea
loop:
    lda totalArea
    clc
    adc base
    sta totalArea
    lda sidesCount
    dec
    sta sidesCount
    bne loop

    ; Calculate the area of the two pentagonal bases
    lda totalArea
    tay
    lda #2
    clc
    adc totalArea
    tya
    sta totalArea

    ; Calculate the area of the three rectangular faces
    lda sideLength
    sta rectBase
    lda height
    sta rectHeight
    lda totalArea
    clc
    adc rectBase
    adc rectBase
    sta totalArea
    lda rectHeight
    tay
    lda #3
    clc
    adc totalArea

    ; Display the final result
    lda totalArea
    jsr printHex

    ; End of program
    rts

printHex:
    ; This subroutine prints a hex number (1 byte) to the screen
    ldx #$04
loop2:
    lda totalArea
    lsr
    lsr
    lsr
    lsr
    pha
    lda #$0F
    and totalArea
    cmp #$0A
    bcc skipHex
    adc #$07
skipHex:
    adc #$30
    jsr $FFD2
    pla
    dex
    bpl loop2
    rts

sidesCount: .byte 0
sideLength: .byte 0
height: .byte 0
base: .byte 0
prismHeight: .byte 0
totalArea: .byte 0
rectBase: .byte 0
rectHeight: .byte 0
