
    .org $0200
    
start:
    lda #0
    sta $02     ; Initialize random number seed
    
generate_loop:
    jsr generate_random_byte
    and #$3F    ; Mask upper two bits to limit to ASCII uppercase letters, numbers, and some symbols
    cmp #$20    ; Check if character is printable
    bpl store_password
    
    jmp generate_loop

store_password:
    sta $00,X   ; Store character in password buffer
    inx         ; Increment buffer index
    cpx #8      ; Check if password is 8 characters long
    bne generate_loop
    
    ldx #8      ; Print newline
print_newline:
    lda #$0D
    jsr $FFD2
    
print_password:
    ldx #0      ; Print password
print_loop:
    lda $00,X
    jsr $FFD2
    inx
    cpx #8
    bne print_loop
    
    rts

generate_random_byte:
    lda $02
    adc #$EE
    sta $02
    rts
    
    .ds 8       ; Reserve space for password buffer
    
    .end start
