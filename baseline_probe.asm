
.org $1000

start:  lda prompt
       jsr print_string

       lda #0
       sta idx

loop:  lda str, x
       cmp #','     ; comma
       beq remove
       cmp #'.'     ; period
       beq remove
       cmp #'!'     ; exclamation mark
       beq remove
       cmp #'?'     ; question mark
       beq remove
       cmp #0
       beq end
       jsr print_char

remove: inx
        lda str, x
        inx
        jmp loop

end:   lda #0
       sta idx
       lda #0
       sta end_char
       jsr print_char

       rts

prompt: .asciiz "Enter a string: "
str:    .byte "Hello, World! This is a test.", 0
idx:    .byte 0
end_char: .byte 0

print_string:
    lda #0
    sta idx
print_char:
    lda str, x
    beq end_print
    jsr $ffd2
    inx
    jmp print_char
end_print:
    rts
