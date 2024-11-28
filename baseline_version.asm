
.equ a, 5
.equ b, 12
.equ c, -6

.equ discr, 0
.equ sqrt, 0
.equ root1, 0
.equ root2, 0

start:
    ; Calculate the discriminant (discr = b^2 - 4ac)
    ldx #b
    lda a
    sta $00
    jsr mul
    ldx $02
    lda #4
    jsr mul
    lda a
    ldx $00
    sec
    sbc $04
    sta discr
    
    ; Check if the discriminant is less than zero
    lda discr
    cmp #0
    bcc no_roots
    
    ; Calculate the square root of the discriminant
    lda discr
    jsr sqrt
    
    ; Calculate the roots
    ldx #b
    lda b
    ldy discr
    clc
    jsr add
    asl
    asl
    sta root1
    
    ldx #b
    lda b
    ldy #0
    clc
    jsr sub
    asl
    asl
    sta root2
    
    ; Output the roots
    lda root1
    sta $FF
    lda root2
    sta $FE
    
    ; Halt the program
    lda #0
    ;jsr $FFD2
    
no_roots:
    ; No real roots
    lda #$FF
    sta $FF
    lda #$FF
    sta $FE
    
    ; Halt the program
    lda #0
    ;jsr $FFD2

mul:
    ldy $00
    lda $01
next:
    beq end
    ldx $02
    sec
    sbc #$01
    sta $02
    ldx $00
    clc
    adc $03
    sta $03
    lda $01
    ldx $01
    dey
    bne next
end:
    rts

add:
    lda $00
    adc $01
    sta $00
    lda $02
    adc $03
    sta $02
    rts

sub:
    lda $00
    sec
    sbc $01
    sta $00
    lda $02
    sec
    sbc $03
    sta $02
    rts

sqrt:
    ldy #16
next_bit:
    asl discr
    rol discr+1
    bcc skipSub
    ldx discr
    sbc #1
    stx discr
skipSub:
    dey
    bne next_bit
    rts
