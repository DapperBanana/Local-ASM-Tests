
; Constants
COLS = 3
ROWS = 3

; Initialize variables
magic_torus_flag: .byte 0
matrix: .byte 3, 1, 2, 2, 3, 1, 1, 2, 3

start:
    lda #0          ; Initialize variables
    sta magic_torus_flag
    
    jsr check_rows  ; Check rows
    
    lda magic_torus_flag
    beq not_magic    ; If magic flag is not set, not a magic torus
    
    jsr check_cols  ; Check columns
    
    lda magic_torus_flag
    beq not_magic    ; If magic flag is not set, not a magic torus
    
    lda #1          ; Set magic flag
    sta magic_torus_flag
    
    ; Add any additional checks here
    
not_magic:
    ; Code to execute if not a magic torus
    ; For example, output 'Not a magic torus!'
    
    rts

check_rows:
    lda #0
    sta row_sum
    sta expected_sum
    ldx #0
    
check_rows_loop:
    lda matrix, x
    clc
    adc row_sum
    sta row_sum
    
    inx
    cpx #COLS
    bne check_rows_loop
    
    lda row_sum
    cmp expected_sum
    bne not_magic
    lda row_sum
    sta expected_sum
    
    ; Check continues to next row
    iny
    cpy #ROWS
    beq check_rows_done
    
    lda #0
    sta row_sum
    jmp check_rows_loop
    
check_rows_done:
    rts

check_cols:
    ldx #0
    
check_cols_loop:
    lda #0
    sta col_sum
    
    ldy #0
check_cols_inner_loop:
    lda matrix, y
    clc
    adc col_sum
    sta col_sum
    
    lda matrix, x
    tay
    inx
    cpx #COLS
    bne check_cols_inner_loop
    
    lda col_sum
    cmp expected_sum
    bne not_magic
    
    dey
    cpy #ROWS
    bne check_cols_loop
    
    rts
