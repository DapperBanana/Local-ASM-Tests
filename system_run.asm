
        .org $0200

start   lda #<decimal     ; Load low byte of decimal number into accumulator A
        sta tmp1           ; Store low byte in temporary variable tmp1
        lda #>decimal     ; Load high byte of decimal number into accumulator A
        sta tmp1+1         ; Store high byte in temporary variable tmp1
        jsr convert        ; Call convert subroutine
        
        ; Your code here
        
        brk

decimal .dw $1234           ; Decimal number to be converted

tmp1    .ds 2               ; Temporary variable to store decimal number

result  .ds 2               ; Variable to store fraction result

convert lda tmp1           ; Load decimal number from tmp1
        tay                ; Transfer to Y register
        
loop    iny                ; Increment Y
        cpy #$0a           ; Compare to 10
        bne loop           ; Branch if not equal
        
        ldx #$00           ; Load 0 into X register
        ldy #$0a           ; Load 10 into Y register
        
divide  lda tmp1           ; Load decimal number from tmp1
        sec                ; Set carry flag
        sbc #$01           ; Subtract 1 from decimal number
        sta tmp1           ; Store new decimal number back in tmp1
        
        bcc remainder      ; Branch if carry flag is clear
        
        inc result         ; Increment result
        jmp divide         ; Jump back to divide
        
remainder
        
        dex                ; Decrement X
        cpx #$05           ; Compare X to 5
        bne divide         ; Branch if not equal
        
        lda tmp1           ; Load decimal number from tmp1
        sta result+1       ; Store high byte of result
        
        rts

        .end
