
        processor 6502
        org $0800

START   ldx #0              ; initialize index X to 0
        lda #$00            ; initialize sum to 0
LOOP    lda $1000,x         ; load the next element from the list
        beq DONE            ; exit loop if element is 0
        clc
        adc A               ; add element to sum
        sta $2000           ; store the sum in memory
        inx                 ; increment index X
        bne LOOP            ; loop back if index not zero
DONE    rts                 ; return from subroutine

        org $1000
; list of elements
        .byte $05, $0A, $15, $20, $00
