
; Calculate edit distance between two strings
; Wagner-Fischer algorithm

    .org $0600

start:
    ; Initialize strings
    lda str1
    sta addr1
    lda str2
    sta addr2

    ; Initialize table
    ldx #$00
init_table_loop:
    lda #$00
    sta table,x
    sta table+256,x
    sta table+512,x
    sta table+768,x
    inx
    cpx #$100
    bne init_table_loop

    ; Initialize first row
    ldx #$01
init_first_row_loop:
    lda x
    sta table,x
    inx
    cpx #$100
    bne init_first_row_loop

    ; Initialize first column
    ldx #$01
init_first_col_loop:
    lda x
    sta table+($100 * x)
    inx
    cpx #$100
    bne init_first_col_loop

    ; Calculate edit distance
    ldy #$01
loop_rows:
    lda addr2,y
    ldx #$01
loop_cols:
    lda addr1,x
    cmp addr2,y
    beq match
    ldy #$00
    lda table,x
    sec
    sbc table-($100 * y)
    lda table-($101 * x)
    cmp table,x
    bcc update_table
    rts

match:
    lda table,x
    rts

update_table:
    lda table-($100 * y)
    iny
    ldy #$00
    sbc table,x
    if <carry> jmp update_table

    inx
    lda table-($101 * x)
    adc table,x
    sta table,x
    rts

str1 .byte "hello",0
str2 .byte "jello",0
addr1 .dsb $100
addr2 .dsb $100
table .dsb $10000

    .end start
