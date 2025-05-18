
        .org $0200

matrix: .byte  1, 0, 0
        .byte  0, 1, 0
        .byte  0, 0, 1

result: .byte 0

start:  ldx #0        ; Initialize loop counter
        stx result   ; Clear result

check:  lda matrix, x  ; Load element from matrix
        cmp matrix+3, x ; Compare with corresponding element in next row
        
        bne not_orthogonal ; If elements are not equal, matrix is not orthogonal
        
        inx          ; Increment loop counter
        cpx #9       ; Check if all elements have been compared
        bne check    ; If not, continue checking
        
        lda #1       ; Set result to 1 if matrix is orthogonal
        sta result

not_orthogonal:
        
        rts

        .end
