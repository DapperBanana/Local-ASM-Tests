
        .org $1000

checkSquare:
        lda $00  ; Load the given number into the accumulator
        cmp #$00 ; Compare it with 0
        beq isSquare ; If it is 0, then it is a perfect square
        
        ldx $00  ; Load the given number into the X register
        lda #$01 ; Load 1 into the accumulator
        sta $01  ; Store 1 in memory location $01
        clc      ; Clear the carry flag
        
innerLoop:
        lda $01   ; Load the current number being checked into the accumulator
        adc $01   ; Add the current number to itself
        cmp $00   ; Compare the result with the given number
        bcc nextNum ; If less than the given number, go to next number
        
        beq isSquare ; If equal to the given number, then it is a perfect square
        
        jmp notSquare ; If greater than the given number, then it is not a perfect square
        
nextNum:
        inx     ; Increment the current number
        cpx $00 ; Compare the current number with the given number
        bne innerLoop ; If not equal, repeat the inner loop
        
        jmp notSquare ; If no perfect square found, then it is not a perfect square

isSquare:
        lda #$01 ; Load 1 into the accumulator (signifying it is a perfect square)
        rts      ; Return from subroutine
        
notSquare:
        lda #$00 ; Load 0 into the accumulator (signifying it is not a perfect square)
        rts      ; Return from subroutine

        .end
