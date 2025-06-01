
; 6502 Assembly program for simulating a basic text-based social media platform

    .org $0200           ; Start program at address $0200
    .asciiz "Hello! Welcome to our social media platform.\n"
    .asciiz "Enter your username: "
    .asciiz "What's on your mind? "
    .asciiz "Posts:\n"
    .asciiz "1. Follow someone\n"
    .asciiz "2. Post\n"
    .asciiz "3. Exit\n"
    
start:
    jsr print_hello
    lda #0
    sta $fb             ; Initialize user id
    
input_username:
    jsr print_username
    jsr read_input
    sta $fb             ; Store user id
    
menu:
    jsr print_menu
    jsr read_input
    cmp #1
    beq follow
    cmp #2
    beq post
    cmp #3
    beq exit

follow:
    jsr print_follow
    jsr read_input
    jmp menu
    
post:
    jsr print_prompt
    jsr read_input
    jsr print_posts
    lda $fb
    jsr print_username
    jsr print_colon
    lda $fc
    jsr print_text
    jsr print_newline
    jmp menu

exit:
    rts

print_hello:
    ldx #0
print_hello_loop:
    lda hello,x
    beq print_newline
    jsr print_char
    inx
    bne print_hello_loop
    rts

print_username:
    ldx #0
print_username_loop:
    lda username,x
    beq print_newline
    jsr print_char
    inx
    bne print_username_loop
    rts

print_menu:
    ldx #0
print_menu_loop:
    lda menu,x
    beq print_newline
    jsr print_char
    inx
    bne print_menu_loop
    rts

print_follow:
    ldx #0
print_follow_loop:
    lda follow,x
    beq print_newline
    jsr print_char
    inx
    bne print_follow_loop
    rts

print_prompt:
    ldx #0
print_prompt_loop:
    lda prompt,x
    beq print_newline
    jsr print_char
    inx
    bne print_prompt_loop
    rts

print_posts:
    ldx #0
print_posts_loop:
    lda posts,x
    beq print_newline
    jsr print_char
    inx
    bne print_posts_loop
    rts

print_username:
    ldx #0
print_username_loop:
    lda username,x
    beq print_newline
    jsr print_char
    inx
    bne print_username_loop
    rts

print_colon:
    lda #':'
    jsr print_char
    rts

print_text:
    ldx #0
print_text_loop:
    lda text,x
    beq print_newline
    jsr print_char
    inx
    bne print_text_loop
    rts

print_newline:
    lda #10
    jsr print_char
    rts

print_char:
    sta $fe
    lda $fb
    jsr $ffd2
    rts

read_input:
    ldx #0
input_loop:
    jsr $ff00
    cmp #$d
    beq input_end
    sta $fc,x
    inx
    jmp input_loop
input_end:
    sta $fc,x
    rts

hello:
    .byte "Hello! Welcome to our social media platform.",0
username:
    .byte "Enter your username: ",0
menu:
    .byte "1. Follow someone",0
    .byte "2. Post",0
    .byte "3. Exit",0
follow:
    .byte "Who would you like to follow? ",0
prompt:
    .byte "What's on your mind? ",0
posts:
    .byte "Posts:",0
text:
    .byte 16
    .byte 0

    .end
