
        .org $0600

start   sei                 ; Disable interrupts
        cld                 ; Clear decimal mode
        lda #$ff            ; Initialize stack pointer
        txa
        pha
        lda #$00
        tay
        txs
        lda #<end
        sta $02
        lda #>end
        sta $03

        lda #<welcome_msg
        jsr print_string

get_name:
        lda #<enter_name_msg
        jsr print_string
        lda #>enter_name_msg
        jsr print_string

        lda #0
        sta name_buffer
        lda #8
        sta name_buffer+1
        lda name_buffer
        ldx #1
read_name_loop:
        jsr read_char
        beq end_read_name
        sta (name_buffer),y
        iny
        cpx #8
        bne read_name_loop
end_read_name:
        lda #0
        sta (name_buffer),y

        lda #<job_title_msg
        jsr print_string
        lda #>job_title_msg
        jsr print_string

        lda #0
        sta title_buffer
        lda #8
        sta title_buffer+1
        lda title_buffer
        ldx #1
read_title_loop:
        jsr read_char
        beq end_read_title
        sta (title_buffer),y
        iny
        cpx #8
        bne read_title_loop
end_read_title:
        lda #0
        sta (title_buffer),y

        lda #<thanks_msg
        jsr print_string

end     rts

read_char:
        lda #0
        sta $C000
        lda #$1F
        sta $C000
        lda $C000
        rts

print_string:
        tay
print_string_loop:
        lda (tay),y
        beq end_print_string
        jsr $FFD2
        iny
        bne print_string_loop
end_print_string:
        rts

        .addr name_buffer
        .addr title_buffer
        .byte 0

welcome_msg:
        .txt "Welcome to the Job Application System!"
        .byte 0

enter_name_msg:
        .txt "Please enter your name (up to 8 characters): "
        .byte 0

job_title_msg:
        .txt "Please enter the job title you are applying for (up to 8 characters): "
        .byte 0

thanks_msg:
        .txt "Thank you for applying!"
        .byte 0
