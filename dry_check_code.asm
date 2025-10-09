
; Calculate the area of a pyramid given base area and height
;
; Inputs:
;   Base area - stored in location $00-$01 (2 bytes)
;   Height - stored in location $02-$03 (2 bytes)
;
; Output:
;   Area of the pyramid - stored in location $04-$05 (2 bytes)

.area equ $04

        .org $0200
        
start:
        lda $00     ; Load the base area LSB
        sta $06     ; Store in temporary location
        lda $01     ; Load the base area MSB
        sta $07     ; Store in temporary location
        lda $02     ; Load the height LSB
        sta $08     ; Store in temporary location
        lda $03     ; Load the height MSB
        sta $09     ; Store in temporary location

        ldx #0
        ldy #0

        ldx $06     ; Load base area LSB into X
        ldy $07     ; Load base area MSB into Y
        jsr multiply16 ; Multiply base area by 16 (shift left 4 bits)
        jsr multiply16 ; Multiply result by 16 again (shift left 4 bits)
        tax         ; Save the result in X register

        ldx $08     ; Load height LSB into X
        ldy $09     ; Load height MSB into Y
        jsr multiply16 ; Multiply height by 16 (shift left 4 bits)

        clc
        lda $04     ; Load the result from previous calculations (base area * 256)
        adc $06     ; Add the height result to get the total area
        sta $04     ; Store the final result

end:
        rts

multiply16:
        jsr multiply4   ; Multiply by 4 (shift left 2 bits)
        jsr multiply4   ; Multiply by 4 again (shift left 2 bits)
        rts

multiply4:
        asl
        rol
        rts
