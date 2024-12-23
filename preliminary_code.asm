
        .org $0200

pet_name    .byte "Pet: ", 0
hunger_text .byte "Hunger: ", 0
hunger_val  .byte 0
thirst_text .byte "Thirst: ", 0
thirst_val  .byte 0
boredom_text.byte "Boredom: ", 0
boredom_val .byte 0

pet_loop:
        lda #0
        jsr clear_screen

        ldx #0
print_pet:
        lda pet_name, x
        beq print_hunger
        jsr $ffd2
        inx
        jmp print_pet

print_hunger:
        jsr print_nl
        ldx #0
        lda hunger_text, x
        beq print_thirst
        jsr $ffd2
        inx
        lda hunger_val
        jsr print_num
        jmp print_thirst

print_thirst:
        jsr print_nl
        ldx #0
        lda thirst_text, x
        beq print_boredom
        jsr $ffd2
        inx
        lda thirst_val
        jsr print_num
        jmp print_boredom

print_boredom:
        jsr print_nl
        ldx #0
        lda boredom_text, x
        beq update_pet
        jsr $ffd2
        inx
        lda boredom_val
        jsr print_num

update_pet:
        lda hunger_val
        clc
        adc #1
        sta hunger_val

        lda thirst_val
        clc
        adc #1
        sta thirst_val

        lda boredom_val
        clc
        adc #1
        sta boredom_val

        jsr delay
        jmp pet_loop

clear_screen:
        lda #147
        jsr $ffd2
        rts

print_nl:
        lda #13
        jsr $ffd2
        lda #10
        jsr $ffd2
        rts

print_num:
        jsr $ffd2
        lda #48
        clc
        adc #10
        rts

delay:
        ldx #0
delay1:
        ldy #0
delay2:
        ldy (0), y
        iny
        cpy #0
        bne delay2
        inx
        cpx #255
        bne delay1
        rts

        .org $fc00
        .word $0200
