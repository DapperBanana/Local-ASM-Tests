
        .org $0200

radius  .byte   3       ; radius of the cone
height  .byte   5       ; height of the cone
volume  .byte   0       ; volume of the cone

        lda     radius      ; load radius into A
        sta     $00         ; store radius at address $00
        lda     height      ; load height into A
        sta     $01         ; store height at address $01
        
        lda     $00         ; load radius from address $00
        jsr     square      ; calculate square of radius
        sta     $02         ; store result at address $02
        
        lda     $01         ; load height from address $01
        jsr     square      ; calculate square of height
        sta     $03         ; store result at address $03
        
        lda     $02         ; load square of radius from address $02
        sta     volume      ; store at volume
        
        lda     $02         ; load square of radius
        cmp     #$01        ; compare with 1
        beq     done        ; branch if equal to 1
        
        lda     $03         ; load square of height
        jsr     multiply    ; multiply square of height with 3.14
        sta     $04         ; store result at address $04
        
        lda     $00         ; load radius from address $00
        jsr     multiply    ; multiply radius with square of height * 3.14
        lda     volume      ; load volume
        clc
        adc     $05         ; add result of multiplication
        sta     volume      ; store result at volume
        
done    ; end program
        rts

multiply
        stx     $05
        lda     $00         ; load A (low byte) operand1
        sec
        sbc     #$00        ; set carry
        lda     $01         ; load B (low byte) operand2
        sec
        sbc     #$00        ; set carry
        sta     $06         ; store operand B
        lda     $00         ; load A (low byte) operand1
        sec
        sbc     #$00        ; set carry
        lda     $02         ; load B (low byte) operand2
        sec
        sbc     #$00        ; set carry
        sta     $07         ; store operand B

        lda     $06         ; load operand B
        clc
        adc     #$00        ; add with carry
        sta     $08         ; store result
        
        lda     $07         ; load operand B
        clc
        adc     #$00        ; add with carry
        sta     $09         ; store result
        
        lda     $08         ; load result
        clc
        adc     $09         ; add with carry
        sta     $0A         ; store result

        ldx     $05
        rts

square  ; calculate square of a number
        sta     $06         ; store the number
        lda     $06         ; load the number
        jsr     multiply    ; multiply the number with itself
        lda     $0A         ; load result
        rts
