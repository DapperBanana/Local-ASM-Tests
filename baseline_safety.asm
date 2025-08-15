
; Virtual Pet Simulator

.petname  .byte "Fido", 0
.happiness  .byte 50
.hunger     .byte 50

start:
    lda #0
    sta .happiness
    sta .hunger

main_loop:
    jsr print_status
    
    lda .happiness
    cmp #50
    bcs play
    
    lda .hunger
    cmp #50
    bcs feed
    
    jmp main_loop

play:
    lda .happiness
    clc
    adc #10
    cmp #100
    bcc no_overflow
    lda #100

no_overflow:
    sta .happiness
    jmp main_loop

feed:
    lda .hunger
    clc
    adc #10
    cmp #100
    bcc no_overflow_feed
    lda #100

no_overflow_feed:
    sta .hunger
    jmp main_loop

print_status:
    jsr clear_screen
    
    lda .petname
    jsr print_string
    jsr print_newline
    
    lda #6
    jsr print_spaces
    
    lda #":)"
    jsr print_string
    
    lda #6
    jsr print_spaces
    
    lda .happiness
    jsr print_decimal
    jsr print_newline
    
    lda .petname
    jsr print_string
    jsr print_newline
    
    lda #6
    jsr print_spaces
    
    lda #"X"
    jsr print_string
    
    lda #6
    jsr print_spaces
    
    lda .hunger
    jsr print_decimal
    jsr print_newline
    
    rts

print_spaces:
    ldx #0
print_spaces_loop:
    lda #" "
    jsr print_char
    inx
    cpx 6
    bne print_spaces_loop
    rts

print_newline:
    lda #13
    jsr print_char
    lda #10
    jsr print_char
    rts

print_string:
    tax
print_string_loop:
    lda .petname, x
    beq print_string_done
    jsr print_char
    inx
    bne print_string_loop

print_string_done:
    rts

print_decimal:
    jsr convert_to_ascii
    jsr print_string
    rts

convert_to_ascii:
    ldy #0
    ldx #0

convert_to_ascii_loop:
    lda #10
    sbc #1
    tay
    stx temp1
    lda temp1
    adc #'0'
    sta temp2
    lda #0
    
    sta temp3
    
    clc
    adc temp2
    sta temp2
    lda temp1
    bne convert_loop2
    rts

convert_loop2:
    lda temp3
    bmi check_neg
    lda temp2
    sta temp4
    ldx temp3
    
    lda temp4
    sta temp2
    ldx temp3
    lda #10
    sbc temp2
    tay
    lda temp4
    sta temp2
    
    rts
    
check_neg:

rts

clear_screen:
    lda #147
    jsr print_char
    lda #128
    jsr print_char
    lda #0
    rts

print_char:
    jsr $ffd2
    rts

.petname:
    .byte "Fido", 0

temp1:  .byte 0
temp2:  .byte 0
temp3:  .byte 0
temp4:  .byte 0

    .end start
