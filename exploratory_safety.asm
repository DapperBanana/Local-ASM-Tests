
.org $0200

start
    lda #$00        ; Initialize index counter
    sta index
    lda #$00        ; Initialize character counter
    sta count
    lda #$00        ; Initialize flag to check for valid protocol
    sta validProtocol
    lda #$00        ; Initialize flag to check for valid domain
    sta validDomain

check_next_char
    lda input, x   ; Load next character from input string
    cmp #0          ; Check if end of string
    beq end

    cmp #$20        ; Check for space character
    beq not_valid_url

    cmp #':'
    beq check_protocol

    cmp #'.'        ; Check for '.' character
    beq check_domain

    inx             ; Move to next character in input string
    inc count       ; Increment character counter
    jmp check_next_char

check_protocol
    cmp #"h"
    beq check_protocol2
    jmp not_valid_url

check_protocol2
    inx
    lda input, x
    cmp #"t"
    beq check_protocol3
    jmp not_valid_url

check_protocol3
    inx
    lda input, x
    cmp #"t"
    beq check_protocol4
    jmp not_valid_url

check_protocol4
    inx
    lda input, x
    cmp #"p"
    beq check_protocol_valid
    jmp not_valid_url

check_protocol_valid
    inx
    lda input, x
    cmp #':'
    beq check_domain
    jmp not_valid_url

check_domain
    lda validProtocol
    cmp #$01
    beq check_domain2
    jmp not_valid_url

check_domain2
    inx
    lda input, x
    cmp #'.'
    beq not_valid_url
    lda input, x
    cmp #0
    beq valid_url
    lda input, x
    cmp #':'
    beq not_valid_url
    inc index
    inc count
    jmp check_domain

valid_url
    lda #$01
    jmp end

not_valid_url
    lda #$00    

end
    sta $0201
    rts

index
    .byte 0
count
    .byte 0
validProtocol
    .byte 0
validDomain
    .byte 0

input
    .asciiz "http://www.example.com"

    .end
