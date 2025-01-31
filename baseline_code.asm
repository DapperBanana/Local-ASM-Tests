
    .org $0200
    
    lda #10    ;Coefficient 'a' in the quadratic equation ax^2 + bx + c = 0
    sta a
    
    lda #5     ;Coefficient 'b' in the quadratic equation ax^2 + bx + c = 0
    sta b
    
    lda #2     ;Coefficient 'c' in the quadratic equation ax^2 + bx + c = 0
    sta c
    
    lda b      ;Load coefficient 'b' into accumulator
    ldx b      ;Load coefficient 'b' into X register
    dex        ;Decrement X so we can multiply by itself (b^2)
    bmi negative
    
    jsr multiply      ;Multiply b by itself to get b squared
    sta bsquared
    
    lda a      ;Load coefficient 'a' into accumulator
    ldx a      ;Load coefficient 'a' into X register
    jsr multiply      ;Multiply a by 4ac
    sty fourac
    
    lda bsquared
    jsr subs        ;Subtract 4ac from b^2 to get the discriminant
    sta discriminant
    
    ldx discriminant
    ldy #0
    bne roots     
    
    lda #0
    sta root1
    lda #0
    sta root2
    bra end
    
roots:
    lda b
    lda lsr
    sta root1
    
    lda b
    clc
    adc discriminant
    lda lda /2
    sta root2
    
end:
    ;End of program
    
multiply:
    tya            ;Transfer Y register to accumulator
    tax            ;Transfer accumulator to X register
    ldy #0          ;Clear the Y register
    
loop:
    bpl add        ;Branch if positive
    ldy #0          ;Set Y register to 0 if multiplier
    beq shift
    
add:
    clc             ;Clear carry flag
    lsr             ;Shift right one bit
    rol             ;Rotate left one bit
    lda 04,x        ;Load the value to multiply by into the accumulator
    adc 0a,x        ;Add the product of the multiplication to the accumulator
    inx             ;Increment X register
    iny             ;Increment Y register
    bne loop       ;Branch if not equal to zero
    
shift:
    lsr             ;Shift the accumulator right one bit
    bx irq        ;Branch and exchange if negative
    
irq:
    tay            ;Transfer accumulator to Y register
    lda #0          ;Clear the accumulator
    rts            ;Return from subroutine
    
subs:
    ;Subtract the contents of Y register from the accumulator
    tay            ;Transfer Y register to the accumulator
    eor #$FF        ;Exclusive OR with #$FF to get the 2s complement
    clc             ;Clear carry
    adc #1          ;Add one to the accumulator
    rts            ;Return from subroutine
    
    .end
