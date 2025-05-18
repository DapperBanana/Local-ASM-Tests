
        .org $0800
        .text

start:
        ; Load input values
        ldx #BASE1_ADDRESS
        lda (x),y
        sta base1
        
        ldx #BASE2_ADDRESS
        lda (x),y
        sta base2

        ldx #HEIGHT_ADDRESS
        lda (x),y
        sta height

        ldx #WIDTH_ADDRESS
        lda (x),y
        sta width

        ; Calculate the area of the trapezoidal prism
        lda base1
        clc
        adc base2
        lsr
        sta temp
        lda temp
        multiply height
        sta temp
        lda base1
        adc base2
        multiply width
        sta temp2
        lda temp
        adc temp2
        sta area
        
        ; Store the result in memory
        ldx #AREA_ADDRESS
        sta (x),y

        ; End of program
        brk

BASE1_ADDRESS:  .byte $00
BASE2_ADDRESS:  .byte $01
HEIGHT_ADDRESS: .byte $02
WIDTH_ADDRESS:  .byte $03
AREA_ADDRESS:   .byte $04

base1:  .byte $00
base2:  .byte $00
height: .byte $00
width:  .byte $00
area:   .byte $00
temp:   .byte $00
temp2:  .byte $00

        .data
        .text "Result: "
        .hex  area
