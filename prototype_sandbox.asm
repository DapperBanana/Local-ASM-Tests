
        processor 6502
        org $8000

num_sides equ 6
side_length equ 5
apothem equ 4

start   lda #num_sides     ; Load number of sides
        sta sides

        lda #side_length    ; Load length of each side
        sta side

        lda #apothem        ; Load apothem
        sta apothem
        
        ; Calculate the area of the polygon
        lda sides
        clc
        lda #2
        adc #apothem
        sta temp
        
        lda temp
        sta denominator
        
        lda side
        sta numerator
        
        lda #nonagon
        jsr div
        
        lda quotient
        sta area
        
        ; Halt the program
        lda #$FF
        jsr $FFFE

nonagon equ 9
sides   dsb 1
side    dsb 1
apothem   dsb 1
area    dsb 2
numerator dsb 2
denominator dsb 2
quotient dsb 2
temp    dsb 2

div     tay
div_loop lda numerator+1
        bcc skip_add
        lda numerator
        sec
        sbc denominator
        sta numerator
        clc
        iny
skip_add lsr
        iny
        beq div_done
        jmp div_loop

div_done dex
        bne div_loop
        lda #$00
        sta quotient+1
        lda denominator
        sec
        sbc numerator
        sta quotient

        rts
