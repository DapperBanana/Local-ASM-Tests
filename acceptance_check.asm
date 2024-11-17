
; 6502 Assembly program to calculate the area of a pyramid
;
; Assume:
; Base area is stored in memory location $00 (2 bytes - low byte first)
; Height of the pyramid is stored in memory location $02
; Result will be stored in memory location $04 (2 bytes - low byte first)

        .org $0200

start   lda $00         ; Load the low byte of base area
        clc             ; Clear the carry flag
        adc $01         ; Add the high byte of base area
        tax             ; Save the result in X register

        lda $02         ; Load the height of the pyramid
        clc             ; Clear the carry flag
        adc $03         ; Add the high byte of height
        tay             ; Save the result in Y register

        lda x           ; Load the base area in X register
        jsr multiply    ; Multiply base area by height
        lda y           ; Load the result into A register
        sta $04         ; Store the result in memory location $04

        lda x+1         ; Load the higher byte of multiplication
        sta $05         ; Store it in memory location $05

done    rts             ; Return from subroutine

; Subroutine to multiply two 16-bit numbers (result in 32-bit)
multiply
        ldx #32         ; Initialize bit count
loop    asl             ; Shift left the result
        bcc skip        ; If carry flag is clear, skip adding
        lda y           ; Add the high byte of second number
        clc
        adc $05
        sta $05
skip    lda x           ; Add the low byte of first number
        adc $04
        sta $04
        dex             ; Decrease the bit count
        bne loop        ; If all bits haven't been processed, repeat loop
        rts             ; Return from subroutine

        .end
