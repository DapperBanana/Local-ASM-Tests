
        .org $0200

matrix  .byte 1, 2, 3, 4
        .byte 2, 5, 6, 7
        .byte 3, 6, 8, 9
        .byte 4, 7, 9, 10

symmetry_check:
        lda #0          ; set counter to 0
        sta counter
        
check_rows:
        lda #0          ; set inner counter to 0
        sta inner_counter
        
check_cols:
        lda counter
        clc
        adc inner_counter
        tax
        
        lda matrix, x
        cmp matrix, x
        
        beq next_cell      ; if equal, go to next cell
        bne not_symmetric  ; if not equal, matrix is not symmetric
        
next_cell:
        inx
        cpx #4
        bne check_cols    ; if inner counter is less than 4, check next column
        
        iny
        cpy #4
        bne check_rows    ; if outer counter is less than 4, check next row
        
        lda #1            ; matrix is symmetric
        rts
        
not_symmetric:
        lda #0            ; matrix is not symmetric
        rts

counter      .byte 0
inner_counter .byte 0

        .end
