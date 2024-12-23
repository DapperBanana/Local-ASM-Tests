
; Check if a given matrix is orthogonal
; Inputs:
; - Matrix stored in memory starting at address MATRIX_ADDR
; Outputs:
; - 1 in register A if matrix is orthogonal, 0 otherwise

      .org $0200               ; Start program at address $0200
      .processor 6502          ; Set processor to 6502

      MATRIX_ADDR = $0300      ; Address where matrix is stored

start lda #0                  ; Initialize accumulator
      sta result              ; Store initial result in memory

      ldx #0                  ; Initialize row index
load_row
      lda MATRIX_ADDR, x      ; Load next row of matrix
      tax                     ; Save current row in X register

      ldy x                   ; Start by comparing row with itself
      jmp compare_rows        ; Jump to compare_rows subroutine

loop_rows
      dex                     ; Decrement row index
      bpl compare_rows        ; Branch if still rows left to compare

      lda #1                  ; Load 1 in accumulator (matrix is orthogonal)
      sta result              ; Store result in memory

      jmp end_program         ; Jump to end_program subroutine

compare_rows
      cpy x                   ; Compare row indices
      beq loop_rows           ; Branch if rows are the same

      ldy x                   ; Start comparing columns
      lda MATRIX_ADDR, y      ; Load corresponding element from first row

loop_columns
      lda MATRIX_ADDR, x      ; Load corresponding element from second row

      cmp #0                  ; Compare elements
      bne set_result_false    ; Branch if elements are not orthogonal

      inx                     ; Increment column index
      iny
      cpy x                   ; Compare column indices
      bne loop_columns        ; Branch if there are more columns to compare

      lda result              ; Load current result
      cmp #0                  ; Compare with 0
      bne end_program         ; Branch if result is false

set_result_false
      lda #0                  ; Load 0 in accumulator (matrix is not orthogonal)
      sta result              ; Store result in memory

end_program
      rts                     ; Return from subroutine

      .org $FFFA               ; Define reset vector
      .word start              ; Set reset vector to start of program

result .byte 0                ; Memory location to store result
