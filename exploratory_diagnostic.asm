
        .org $0200
start:  lda base     ; Load base side length into accumulator
        sta $00      ; Store base side length in memory
        lda height   ; Load height into accumulator
        sta $01      ; Store height in memory

        ; Calculate the area of the pentagonal prism
        lda $00      ; Load base side length from memory
        sta $02      ; Store base side length for further calculations
        lda $01      ; Load height from memory
        sta $03      ; Store height for further calculations
        lda $02      ; Load base side length
        clc
        adc $02      ; Add base side length to itself
        tax          ; Store result in X register
        lda $02      ; Load base side length
        asl          ; Multiply base side length by 2
        adc $02      ; Add the original base side length
        tax          ; Store result in X register

        lda $03      ; Load height
        tay          ; Store height in Y register
        ldx #5       ; Load number of sides (pentagon)
        lda $02      ; Load base side length
        sta $05      ; Store base side length total in $05

calculate_area:
        lda $05      ; Load current base side length total
        clc          ; Clear carry flag
        adc $02      ; Add base side length to total area
        sta $05      ; Store updated total in $05
        dey          ; Decrement Y register
        bne calculate_area ; Continue loop until all sides are calculated

        lda $05      ; Load total area of all sides
        tax          ; Store in X register
        ldx #$00     ; Load accumulator with 0
        lda $03      ; Load height
        asl          ; Multiply height by 2
        adc $03      ; Add original height to itself
        tay          ; Store result in Y register
        lda $03      ; Load height
        adc $02      ; Add height to base side length
        tay          ; Store result in Y register
        lda $02      ; Load base side length
        sta $04      ; Store base side length in $04
        lda $05      ; Load total area of all sides
        adc $04      ; Add total area to base side length
        tax          ; Store result in X register

        jsr display_result ; Call subroutine to display the result

end:    rts

base:   .byte $05    ; Base side length
height: .byte $03    ; Height

display_result:
        lda $00      ; Load area into accumulator
        sta $06      ; Store in memory
        lda $01      ; Load area into accumulator
        sta $07      ; Store in memory
        rts     

        .end start
