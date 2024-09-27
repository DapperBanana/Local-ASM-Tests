
        .org $0200

start   lda number      ; Load number into the accumulator
        jsr isNarcissistic  ; Call the isNarcissistic subroutine
        bcc notNarcissistic  ; Branch if not narcissistic
        lda #1              ; Load 1 into the accumulator
        sta result          ; Store result
        rts

notNarcissistic
        lda #0              ; Load 0 into the accumulator
        sta result          ; Store result
        rts

isNarcissistic
        ldx #0              ; Initialize sum to 0
        ldy #0              ; Initialize power to 0
        
loop    lda number      ; Load number into the accumulator
        cmp #0              ; Compare to 0
        beq calcResult      ; Branch to calculate result if number is 0
        
        ldx #0              ; Reset sum to 0
        ldy #0              ; Reset power to 0
        lda number          ; Load number into the accumulator

innerLoop
        lsr                 ; Shift accumulator right
        bcc incrementPower   ; Branch if carry is clear
        inc power           ; Increment power
        
incrementPower
        iny                 ; Increment power
        
        bcc innerLoop       ; Branch to inner loop
        
calcResult
        lda number          ; Load number into the accumulator
        sta temp1           ; Store number in temp variable
        ldx #0              ; Reset sum to 0
        
calcLoop
        ldy #0              ; Reset power to 0
        lda temp1           ; Load temp variable
        
innerCalcLoop
        lda temp1          ; Load temp variable
        lsr                ; Shift accumulator right
        bcc incPower       ; Branch if carry is clear
        
        inc power         ; Increment power
        
incPower
        iny                ; Increment power
        dey                ; Decrement power (adjustment)
        
        lda temp1          ; Load temp variable
        ldx #0             ; Reset sum to 0
        
        sec                ; Set carry flag
        lda temp1          ; Load temp variable
        sbc #$30           ; Subtract 48 (ASCII conversion)
        sbc #$30           ; Subtract 48 for second digit
        
        ldx power          ; Load power into X
        clc                ; Clear carry flag
        
        tax                ; Transfer power to X
        dcp                ; Compare accumulator to previous power
        bne endCalcLoop    ; Branch if not narcissistic
        
        adc sum            ; Add sum to accumulator
        sta sum            ; Store sum
        
endCalcLoop
        dey                ; Decrement power
        
        bcc innerCalcLoop  ; Branch to inner calculation loop
        
        lda sum            ; Load sum into the accumulator
        clc                ; Clear carry flag
        cmp temp1          ; Compare accumulator to original number
        bne notNarcissistic  ; Branch if not narcissistic
        
        lda #1            ; Load 1 into the accumulator
        sec               ; Set carry flag
        sbc #$30         ; Subtract 48 (ASCII conversion)
        sta result       ; Store result
        
        rts

number  .byte $38         ; Number to check (e.g. 153)
power   .byte $00         ; Power variable
result  .byte $00         ; Result variable
sum     .byte $00         ; Sum variable
temp1   .byte $00         ; Temporary variable

        .end
