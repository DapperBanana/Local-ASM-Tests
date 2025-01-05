
        .org $0200

        ldx #0          ; Initialize matrix counter
loop:
        lda matrix, x   ; Load element of matrix into accumulator
        tax             ; Save element index

        ldy #0          ; Initialize dot product counter
inner_loop:
        lda matrix, y   ; Load element of matrix into accumulator
        mul matrix, x   ; Multiply element with corresponding element
        clc             ; Clear carry flag
        adc accumulator ; Add result to dot product counter
        dey             ; Decrement counter
        bpl inner_loop  ; Continue inner loop if not finished

        beq next_row    ; If the dot product is zero, move to the next row

        inx             ; Increment matrix counter
        cpx #matrix_size; Check if end of matrix reached
        bne loop        ; If not, continue checking matrix

        lda #pass_message
        jsr output_string
        jmp end

next_row:
        inx             ; Increment matrix counter
        cpx #matrix_size; Check if end of matrix reached
        beq orthogonal  ; If end of matrix reached, matrix is orthogonal

        jmp loop        ; Continue checking matrix

orthogonal:
        lda #orthogonal_message
        jsr output_string

end:
        rts

accumulator: .byte 0
matrix_size: .byte 3
matrix: .byte 1, 0, 0, 0, 1, 0, 0, 0, 1

output_string:
        ldx #0
print_char:
        lda accumulator, x
        beq end_print
        jsr $ffd2
        inx
        jmp print_char

end_print:
        rts

pass_message: .byte "Matrix is not orthogonal.", $00
orthogonal_message: .byte "Matrix is orthogonal.", $00
