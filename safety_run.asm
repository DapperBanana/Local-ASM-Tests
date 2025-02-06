
; Check if a 3x3 matrix is symmetric

        .org $2000

matrix  .byte 1, 2, 3
        .byte 2, 4, 5
        .byte 3, 5, 6

        ldx #0         ; Initialize outer loop counter
outer   lda matrix, x ; Load outer loop element
        sta $f0       ; Store it in a temporary memory location

        ldy #0         ; Initialize inner loop counter
inner   lda matrix, y ; Load inner loop element
        cmp $f0       ; Compare with the corresponding outer loop element
        bne not_symmetric ; If not equal, matrix is not symmetric

        iny            ; Increment inner loop counter
        cpy #3         ; If inner loop counter is 3, move to next row
        bne inner      ; Otherwise, continue inner loop

        inx            ; Increment outer loop counter
        cpx #3         ; If outer loop counter is 3, matrix is symmetric
        beq symmetric

        lda matrix, x   ; Load next outer loop element
        sta $f0         ; Store it in a temporary memory location
        ldy #$00        ; Reset inner loop counter
        jmp inner       ; Continue inner loop

symmetric
        lda #$01       ; Load 1 to indicate symmetric matrix
        jmp end

not_symmetric
        lda #$00       ; Load 0 to indicate non-symmetric matrix
end     sta $ff        ; Store the result in memory location $ff

        rts            ; End of program
