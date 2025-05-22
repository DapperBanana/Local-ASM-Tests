
        .org $0200  ; Start program at memory address $0200
        
check_symmetric:
        ldx #0       ; Initialize index X to 0
        
check_rows:
        lda matrix, x  ; Load element from matrix at index X
        sta temp1
        ldy #0       ; Initialize index Y to 0
        
check_columns:
        lda matrix, x  ; Load element from matrix at index X
        sta temp2
        lda matrix, y  ; Load element from matrix at index Y
        cmp temp2    ; Compare element from matrix at index X with element from matrix at index Y
        bne not_symmetric  ; Branch if not equal
        
        iny          ; Increment index Y
        cpy #5       ; Check if all columns have been compared
        bne check_columns
        
        inx          ; Increment index X
        cpx #5       ; Check if all rows have been compared
        bne check_rows
        
        lda #$01     ; Set result to symmetric
        rts          ; Return from subroutine
        
not_symmetric:
        lda #$00     ; Set result to not symmetric
        rts          ; Return from subroutine
        
        .org $0320
        
matrix:
        .byte 1, 2, 3, 4, 5
        .byte 2, 3, 4, 5, 6
        .byte 3, 4, 5, 6, 7
        .byte 4, 5, 6, 7, 8
        .byte 5, 6, 7, 8, 9
        
temp1:   .byte 0
temp2:   .byte 0
