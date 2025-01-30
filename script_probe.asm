
        .org $0200

start   lda #<message
        sta lo
        lda #>message
        sta hi

loop    jsr print_message
        
        lda #<prompt
        sta lo
        lda #>prompt
        sta hi
        jsr print_message

        lda #<input_buffer
        sta lo
        lda #>input_buffer
        sta hi
        jsr input_string

        lda #<input_buffer
        jsr check_input

        lda #<clear_screen
        sta lo
        lda #>clear_screen
        sta hi
        jsr clear_screen

        jmp loop

message .byte "Welcome to the Spaceship Game!\0"
prompt  .byte "> \0"
input_buffer .byte 0,0,0,0,0
clear_screen .byte $93, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
lo      .byte 0
hi      .byte 0

print_message:
        ldy #0
loop1   lda (lo),y
        beq done
        jsr $ffd2
        iny
        bne loop1
done    rts

input_string:
        ldy #0
loop2   jsr $ffd2
        cmp #13
        beq done2
        sta (lo),y
        iny
        bne loop2
done2   rts

check_input:
        ldx #0
loop3   lda (lo),x
        beq done3
        cmp #"A"
        beq valid_input
        inx
        bne loop3
valid_input
        rts
done3   lda #<invalid_message
        sta lo
        lda #>invalid_message
        sta hi
        jsr print_message
        jmp loop

invalid_message .byte "Invalid input, please try again.\0"
