
        .org $0200

number  .byte $2A         ; Change the number here

        lda number        ; Load the number into the accumulator
        and #$01           ; Mask the least significant bit
        beq even          ; If the result is 0, the number is even
        jmp odd

even    lda #$00           ; Load 0 into the accumulator (even number)
        rts               ; Return from subroutine

odd     lda #$01           ; Load 1 into the accumulator (odd number)
        rts               ; Return from subroutine

        .end
