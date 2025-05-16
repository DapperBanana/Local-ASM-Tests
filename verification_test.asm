
        ; Program to calculate the area of a rectangle given its length and width
        
        .org $0200      ; Set program start address
        
length  .byte $05      ; Define length of rectangle
width   .byte $0A      ; Define width of rectangle

area    .byte $00      ; Define variable to store area

        lda length      ; Load length into accumulator
        clc             ; Clear carry flag
        adc width       ; Add width to accumulator
        sta area        ; Store result in area variable
        
        lda length      ; Load length into accumulator
        adc width       ; Add width to accumulator
        sta area+1      ; Store carry result in higher byte of area variable
        
        lda area        ; Load lower byte of area into accumulator
        ldx area+1      ; Load higher byte of area into X register
        
        ; Print the result
        
        lda $FDDA       ; Load address of print function into accumulator
        jsr $FFD2       ; Jump to subroutine to print result
        
        rts             ; Return from subroutine
        
; Print function to display the result

        .org $FFD2
        
print   lda #$0D       ; Load carriage return into accumulator
        jsr $FFD2       ; Jump to subroutine to print carriage return
        
        lda #$00        ; Load X register with 0
loop    lda area,X     ; Load character to print into accumulator
        clc             ; Clear carry flag
        adc #$30        ; Add offset to convert to ASCII
        jsr $FFD2       ; Jump to subroutine to print character
        inx             ; Increment X register
        cpx #$02        ; Compare X register with 2
        bne loop        ; Branch if not equal to loop
        
        lda #$0D       ; Load carriage return into accumulator
        jsr $FFD2       ; Jump to subroutine to print carriage return
        
        rts             ; Return from subroutine
