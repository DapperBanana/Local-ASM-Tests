
    .org $0600   ; Program start address
    .entrypoint  ; Set program entry point

    ; Define memory locations
    USER_NAME       .byte "John Doe", $00 ; User name
    POSTS           .byte 0              ; Number of posts
    POST_1          .byte "Hello, World!", $00 ; First post
    POST_2          .byte "This is my second post.", $00 ; Second post

    ; Start of program
start:
    lda #<USER_NAME
    sta $0400
    lda #>USER_NAME
    sta $0401

    ldx #0
    lda POSTS
    beq first_post

second_post:
    lda #<POST_2
    sta $0400
    lda #>POST_2
    sta $0401
    jmp end

first_post:
    lda #<POST_1
    sta $0400
    lda #>POST_1
    sta $0401

end:
    ; Halt the program
    brk

    .end        ; End of program
