
    .org $0200
    
reset:
    lda #$00
    sta current_steps
    
main_loop:
    jsr print_menu
    
    lda #$ff
    sta choice
    
    jsr get_input
    
    cmp #"1"
    beq add_steps
    cmp #"2"
    beq show_steps
    jmp main_loop
    
add_steps:
    lda current_steps
    clc
    adc #1
    sta current_steps
    jmp main_loop
    
show_steps:
    jsr clear_screen
    
    lda current_steps
    jsr print_number
    
    jmp main_loop
    
get_input:
    jsr getchar
    sta choice
    rts
    
print_menu:
    lda #<menu
    ldy #>menu
    jsr print_string
    rts
    
print_number:
    ldx #02
loop:
    asl
    rol
    dex
    bpl loop
    jsr putchar
    rts
    
print_string:
    lda (y),x
    beq end_string
    jsr putchar
    inx
    iny
    jmp print_string
end_string:
    rts
    
getchar:
    lda $FF00
    rts
    
putchar:
    sta $FF02
    rts
    
clear_screen:
    lda #" "
    jsr putchar
    lda #04
cls_loop:
    jsr putchar
    lda #$9b
    jsr putchar
    lda #$ff
    jsr putchar
    inx
    bne cls_loop
    rts
    
menu:
    .text "Fitness Tracking System\n"
    .text "1. Add Steps\n"
    .text "2. Show Steps\n"
    .byte 0
    
choice:
    .byte 0
    
current_steps:
    .byte 0
    
    .end
