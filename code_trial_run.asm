
        .org $0200

a       .byte 1           ; coefficient 'a'
b       .byte 2           ; coefficient 'b'
c       .byte 1           ; coefficient 'c'
quad1   .word 0           ; first root
quad2   .word 0           ; second root

        ldx #0             ; clear index register
        lda a,x            ; load coefficient 'a' into accumulator
        sta $00            ; store it in memory at location $00
        lda b,x            ; load coefficient 'b' into accumulator
        sta $01            ; store it in memory at location $01
        lda c,x            ; load coefficient 'c' into accumulator
        sta $02            ; store it in memory at location $02
        
        lda $01            ; load coefficient 'b' into accumulator
        ldx #1             ; load index register with value 1
        lda $01            ; load coefficient 'b' into accumulator
        sbc $01            ; subtract b squared from b squared
        sta $03            ; store result in memory at location $03
        
        ldx #0             ; clear index register
        lda $00            ; load coefficient 'a' into accumulator
        tax                ; transfer it to index register
        asl                ; multiply by 2
        sta $04            ; store result in memory at location $04
        
        ldx #0             ; clear index register
        lda $03            ; load b squared - 4ac into accumulator
        tax                ; transfer it to index register
        beq nosolution     ; if value in accumulator is 0, jump to nosolution
        
        ldx #0             ; clear index register
        lda $04            ; load 2a into accumulator
        tax                ; transfer it to index register
        
        lda $03            ; load b squared - 4ac into accumulator
        ldx #0             ; clear index register
        clc                ; clear carry flag
        adc $03            ; add b squared - 4ac to accumulator
        jsr sqrt           ; call subroutine to find square root
        sta quad1,x        ; store result in memory at location quad1
        
        lda $04            ; load 2a into accumulator
        ldx #0             ; clear index register
        clc                ; clear carry flag
        adc $03            ; add b squared - 4ac to accumulator
        jsr sqrt           ; call subroutine to find square root
        sta quad2,x        ; store result in memory at location quad2

        jmp end            ; jump to end of program
        
nosolution:

        lda #$ff           ; load value -1 into accumulator
        sta quad1,x        ; store result in memory at location quad1
        sta quad2,x        ; store result in memory at location quad2
        
end:
        rts

sqrt:
        ; subroutine to find square root
        pha                ; push accumulator onto stack
        ldx #0             ; clear index register
        
nextdigit:
        lda quad1,x        ; load value from memory at location quad1 into accumulator
        beq done           ; if value in accumulator is 0, jump to done
        lsr                ; divide accumulator by 2
        sta quad1,x        ; store result back in memory at location quad1
        
        lda quad2,x        ; load value from memory at location quad2 into accumulator
        asl                ; multiply accumulator by 2
        sta quad2,x        ; store result back in memory at location quad2
        
        inx                ; increment index register
        bne nextdigit      ; branch to nextdigit
        
done:
        pla                ; pull value from stack into accumulator
        rts
