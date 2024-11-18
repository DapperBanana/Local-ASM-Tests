
    .org $0200

start:
    ldx #$00  ; initialize index register
    lda message,x  ; load message character
    beq end  ; check for end of message
    jsr print_char  ; print character
    inx  ; increment index
    jmp start  ; repeat

end:
    rts  ; return from subroutine

print_char:
    sta $ff00  ; store character in output register
    rts  ; return from subroutine

message:
    .asciiz "Welcome to the traffic simulation!\n"

    .org $fffe
    .word start  ; start address

    .end
