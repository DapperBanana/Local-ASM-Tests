
; Stock Trading System

.INCLUDE "vcs.h"

STOCK_PRICE = $50

    org $FC0

    lda #STOCK_PRICE
    sta stock_price

main:    LDA #0
    sta player_balance
    LDA #0
    sta player_stock

loop:
    lda #0
    jsr input
    cmp #'1'
    beq buy_stock
    cmp #'2'
    beq sell_stock
    cmp #'3'
    beq display_balance
    jmp invalid_input

buy_stock:
    lda player_balance
    clc
    lda stock_price
    adc #0
    sta player_balance

    lda player_stock
    clc
    adc #1
    sta player_stock
    jmp loop

sell_stock:
    lda player_balance
    clc
    lda stock_price
    sec
    sbc #0
    sta player_balance

    lda player_stock
    clc
    sbc #1
    sta player_stock
    jmp loop

display_balance:
    lda player_balance
    jsr print_num
    jmp loop

invalid_input:
    lda #"Invalid input, please try again"
    jsr print_string
    jmp loop

input:
    jsr get_char
    rts

print_num:
    JSR NUM2TXT
    jsr print_string
    rts

print_string:
    JSR SENDCH
    ldx #0
loop1:
    lda (player_balance), x
    beq exit
    JSR SENDCH
    inx
    jmp loop1

exit:
    rts

player_balance: .byte 0
player_stock: .byte 0
stock_price: .byte 0

    .ORG $FFE4
    .WORD main
