
        .org $0200

check_symmetry:
        ldx #$00              ; Initialize row index
loop1:  lda matrix, x          ; Load value at matrix[x]
        sta row_start          ; Store starting address of current row
        
        ldy #$00              ; Initialize column index
loop2:  lda matrix, y          ; Load value at matrix[y]
        cmp row_start, y       ; Compare with corresponding value in current row
        bne not_symmetric      ; Branch if not symmetric
        
        iny                   ; Increment column index
        cpy #$04              ; Check if reached end of row
        bne loop2             ; Loop back if not
        
        inx                   ; Increment row index
        cpx #$04              ; Check if reached end of matrix
        bne loop1             ; Loop back if not
        
        lda #$01              ; Matrix is symmetric
        rts
        
not_symmetric:
        lda #$00              ; Matrix is not symmetric
        rts
        
matrix:
        .byte 1, 2, 3, 4
        .byte 2, 5, 6, 7
        .byte 3, 6, 8, 9
        .byte 4, 7, 9, 10
        
row_start:
        .byte $00

        .end
