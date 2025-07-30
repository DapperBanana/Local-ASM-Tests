
; Calculate the area of a triangle given its three sides
; Triangle area = sqrt(s * (s - side1) * (s - side2) * (s - side3)), where s = (side1 + side2 + side3) / 2

        .org $0200

side1   .byte 10
side2   .byte 12
side3   .byte 15

result  .word 0

        lda side1      ; Load side1 into accumulator
        clc
        adc side2      ; Add side2 to accumulator
        adc side3      ; Add side3 to accumulator
        lsr            ; Divide by 2
        sta result     ; Store result in memory
        
        lda result     ; Load result back into accumulator
        sec
        sbc side1      ; Subtract side1
        tax            ; Store the result in X
        lda result
        sbc side2      ; Subtract side2
        tay            ; Store the result in Y
        lda result
        sbc side3      ; Subtract side3
        
        jsr sqrt       ; Call square root subroutine
        
        ldx #2         ; Multiply the results
        ldy #0
        lda result
        jsr mul
        
        sta result     ; Store final result in memory
        
        rts

mul     lsr            ; Shift the multiplier
        bcc no_add     ; If bit 0 is 0, jump to no_add
        clc
        adc x          ; Add X to the result
no_add  rol            ; Rotate the result left
        dey            ; Decrement the multiplier
        bne mul        ; If multiplier is not 0, continue multiplying
        rts

sqrt    ldx #0         ; Initialize X to 0
        clc
sqrt_loop
        cmp x           ; Compare the result with X
        bcc sqrt_end    ; If result is less than (X + 1)^2, jump to sqrt_end
        inx            ; Increment X
        clc
        adc x           ; Add X to the result
        bmi sqrt_loop   ; If the result is negative, continue looping
sqrt_end
        lda x           ; Load X into accumulator
        sta result      ; Store result in memory
        rts
