
; Define constants
.equ MAX_LEN, 10
.equ STR1_ADDR, $1000
.equ STR2_ADDR, $2000

; Define variables
.segment "ZEROPAGE"
cur_row .dsb 11
last_row .dsb 11

.segment "CODE"
start:
    ; Initialize variables
    ldx #0
init_loop:
    lda #$ff
    sta cur_row, x
    sta last_row, x
    inx
    cpx MAX_LEN
    bne init_loop

    ; Load strings into memory
    ldx #0
load_str1_loop:
    lda str1, x
    sta STR1_ADDR, x
    inx
    cpx MAX_LEN
    bne load_str1_loop

    ldx #0
load_str2_loop:
    lda str2, x
    sta STR2_ADDR, x
    inx
    cpx MAX_LEN
    bne load_str2_loop

    ; Calculate edit distance
    ldx #0
row_loop:
    lda STR2_ADDR, x
    beq end_calculation

    lda STR1_ADDR, x
    sta cur_row, x

    ldx #1
inner_loop:
    lda cur_row, x
    sec
    sbc last_row, x
    tax

    lda last_row, x
    cmp cur_row, x
    bcc continue_inner_loop

    lda cur_row, x
    sta last_row, x

continue_inner_loop:
    inx
    lda cur_row, x
    cmp #1
    beq end_calculation
    bne inner_loop

    lda last_row, x
    inc
    tax
    lda last_row, x
    inc
    tax

    lda cur_row, x
    cmp #1
    beq end_calculation
    bne inner_loop

end_calculation:
    inx
    lda cur_row, x
    jmp row_loop

    ; Strings to be compared
str1: .asciiz "kitten"
str2: .asciiz "sitting"
