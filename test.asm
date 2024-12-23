
; 6502 Assembly program to check if a given number is a Harshad (Niven) number

        .org $0200      ; Start program at address $0200

start:
        lda number      ; Load the number to check into the accumulator
        cmp #$00        ; Compare with 0
        beq not_harshad ; Branch to not_harshad if number is 0
        jsr sum_digits  ; Call subroutine to sum the digits of the number
        tax             ; Transfer the sum to X register
        lda number      ; Reload the number into accumulator
        ldx #$00        ; Load 0 into X register
        clc             ; Clear carry flag
        div divisor     ; Divide the number by 10
        bcc divide_loop ; Branch if no carry
        inc x           ; Increment X register
        jmp divide_loop ; Jump back to divide_loop
divide_loop:
        adc #$00        ; Add 0 to accumulator
        div divisor     ; Divide number by 10
        bcc divide_loop ; Branch if no carry
        inc x           ; Increment X register
not_harshad:
        lda #$00        ; Load 0 into accumulator
        sta result      ; Store 0 in result (not Harshad)
        rts             ; Return to caller

sum_digits:
        tay             ; Transfer accumulator to Y register
sum_loop:
        and #$0F        ; Mask upper nibble
        tax             ; Transfer to X register
        sta temp        ; Store in temp
        ldx temp        ; Load temp into X register
        tya             ; Transfer Y register to accumulator
        lsr             ; Shift right
        lsr             ; Shift right
        lsr             ; Shift right
        lsr             ; Shift right
        sta number      ; Store back into number
        clc             ; Clear carry flag
        adc tax         ; Add temp to accumulator
        sta temp        ; Store in temp
        cpy #$00        ; Compare Y register with 0
        bne sum_loop    ; Branch if not equal to 0
        tax             ; Transfer sum to X register
        rts             ; Return to caller

number: .byte $12       ; Input number to check
divisor: .byte $0A      ; Divisor (10)
result: .byte $00       ; Result (0 if not Harshad)
temp: .byte $00         ; Temporary storage for sum

        .end            ; End of program
