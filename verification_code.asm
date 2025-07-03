
; Check if a given matrix is invertible
       .org $0600         ; Start address of the program
       
       LDX #0            ; Initialize counter for columns
outer_loop:
       LDA #0            ; Initialize determinant to 0
       LDY #0            ; Initialize counter for rows
inner_loop:
       LDA matrix, X     ; Load element from matrix
       STA $C0           ; Store element in temporary memory
       
       ; Calculate determinant
       LDA matrix, X
       CMP matrix, Y
       BEQ skip_mul
       SEC
       SBC $C0
       JMP skip_add
skip_mul:
       LDA matrix, X
       CLC
       ADC $C0
skip_add:
       
       INY               ; Increment row counter
       INY
       BNE inner_loop    ; Loop until all rows are checked
       
       BEQ invertible    ; Matrix is invertible
       
       INX               ; Increment column counter
       INX
       CPX #16           ; Check if all columns have been checked
       BNE outer_loop    ; Loop until all columns are checked
       
       JMP not_invertible ; Matrix is not invertible
       
invertible:
       ; Matrix is invertible
       RTS
       
not_invertible:
       ; Matrix is not invertible
       LDA #0
       STA $C0
       RTS
       
matrix:
       .byte 2, 3, 1, 4    ; Define the matrix
       .byte 4, 2, 3, 1
       .byte 3, 1, 4, 2
       .byte 1, 4, 2, 3
