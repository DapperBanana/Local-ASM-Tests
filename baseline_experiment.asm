
        .segment "TEXT"

triangle_area:
        lda side1      ; load side 1 into the accumulator
        sta temp1      ; store side 1 in a temporary location
        lda side2      ; load side 2 into the accumulator
        sta temp2      ; store side 2 in a temporary location
        lda side3      ; load side 3 into the accumulator
        sta temp3      ; store side 3 in a temporary location
        
        lda side1      ; load side 1 into the accumulator
        clc            ; clear the carry flag
        adc side2      ; add side 2 to the accumulator
        adc side3      ; add side 3 to the accumulator
        sta temp4      ; store the sum of the sides in a temporary location
        
        lda temp4      ; load the sum of the sides into the accumulator
        ldx #2         ; load the value 2 into the X register
        jsr div         ; call the division subroutine
        sta s          ; store the result in the location s
        
        lda s           ; load the result into the accumulator
        ldx s+1         ; load the high byte into the X register
        jsr mul         ; call the multiplication subroutine
        
        lda mult+1     ; load the high byte of the result into the accumulator
        clc            ; clear the carry flag
        adc temp1      ; add side 1 to the accumulator
        adc temp2      ; add side 2 to the accumulator
        adc temp3      ; add side 3 to the accumulator
        tax            ; transfer the result to the X register
        
        lda mult       ; load the low byte of the result into the accumulator
        rts            ; return from subroutine

mult:   
        ldx #0
        ldy #0
next:   clc
        lda s,x
        adc s+2,x
        sta temp
        lda mult,x
        adc temp
        sta mult,x
        lda mult+1,x
        adc temp+1
        sta mult+1,x
        dex
        dex
        cpx #0
        bne next
        rts

div:    
        ldx #0
        ldy #0
        lda #0
        sta remain+
loop:   lda s,x
        sec
        sbc s+2,x
        sta remain,x
        dex
        dex
        cpx #0
        bne loop
        ldx s+1
        ldy #0
        lda #0
next2:  lda remain,x
        bcc skip
        inc remain
skip:   asl acc
        ror remain
        ror remain+1
        dex
        dex
        cpx #0
        bne next2
        rts

        .segment "DATA"

s:      .byte 0, 0
remain: .byte 0, 0
temp:   .byte 0

        .segment "CODE"

start:  lda #20        ; load the first side of the triangle
        sta side1
        lda #30        ; load the second side of the triangle
        sta side2
        lda #40        ; load the third side of the triangle
        sta side3
        jsr triangle_area  ; call the triangle area calculation subroutine
        ; the result should be stored in the accumulator and the X register

        ; your code here

side1:  .byte 0
side2:  .byte 0
side3:  .byte 0
temp1:  .byte 0
temp2:  .byte 0
temp3:  .byte 0
temp4:  .byte 0
mult:   .byte 0, 0
