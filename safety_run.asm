
        .org $1000  ; Start address of program
        ldx #0      ; Initialize X register to 0
        ldy #0      ; Initialize Y register to 0

        lda A_coeff  ; Load A coefficient into accumulator
        sta A        ; Store A coefficient in memory at A address

        lda B_coeff  ; Load B coefficient into accumulator
        sta B        ; Store B coefficient in memory at B address

        lda C_coeff  ; Load C coefficient into accumulator
        sta C        ; Store C coefficient in memory at C address

        lda B        ; Load B coefficient into accumulator
        sec          ; Clear carry flag
        sbc B        ; Negate B coefficient
        sta B_neg    ; Store negated B coefficient in memory

        lda A        ; Load A coefficient into accumulator
        asl          ; Shift A to the left
        tax          ; Save shifted A value in X register

        lda C        ; Load C coefficient into accumulator
        clc          ; Clear carry flag
        adc C        ; Add C to accumulator
        sta C_sum    ; Store sum of A and C in memory

        lda B_neg    ; Load negated B coefficient into accumulator
        ldx #0       ; Initialize X register to 0
        ldy #0       ; Initialize Y register to 0

        lda C_sum    ; Load sum of A and C into accumulator
        jsr Sqrt     ; Call square root subroutine

        sta Root1    ; Store first root in Root1 memory location

        lda B_neg    ; Load negated B coefficient into accumulator
        sec          ; Set carry flag
        sbc C_sum    ; Subtract sum of A and C from B
        jsr Sqrt     ; Call square root subroutine

        sta Root2    ; Store second root in Root2 memory location

Sqrt:
        lda #0       ; Initialize accumulator to 0
        sta Temp     ; Store 0 in Temp memory location

        loop:
            cmp Temp      ; Compare current value with Temp
            beq done      ; If equal, jump to done
            lda Temp      ; Load current value into accumulator
            clc            ; Clear carry flag
            adc #1         ; Increment value by 1
            sta Temp      ; Store incremented value in Temp memory location
            jmp loop      ; Jump back to loop

        done:
            lda Temp      ; Load final value into accumulator
            rts           ; Return from subroutine

A_coeff .byte 1   ; A coefficient of quadratic equation
B_coeff .byte 3   ; B coefficient of quadratic equation
C_coeff .byte 2   ; C coefficient of quadratic equation

A .byte 0         ; Memory location to store A coefficient
B .byte 0         ; Memory location to store B coefficient
C .byte 0         ; Memory location to store C coefficient
B_neg .byte 0     ; Memory location to store negated B coefficient
C_sum .byte 0     ; Memory location to store sum of A and C
Root1 .byte 0     ; Memory location to store first root
Root2 .byte 0     ; Memory location to store second root
Temp .byte 0      ; Memory location to store temporary value
