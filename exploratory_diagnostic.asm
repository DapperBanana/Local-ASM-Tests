
    .org $0600

; Constants
APPLTXT = $9601
HOME    = $9605

; Variables
address .ds 4
buffer  .ds 16

start:
    lda #<buffer  ; Load address of buffer into X
    ldx #>buffer
    sta address
    sta address+1

input_loop:
    lda #10       ; Wait for keypress
    jsr $ffd2

    cmp #13       ; Check for return key
    beq check_ip  ; If return key, check if IP is valid

    sta (address),y  ; Store input character in buffer
    iny
    bne input_loop  ; Repeat until end of buffer
    lda address+1
    clc
    adc #16         ; Move to next block of buffer
    sta address+1
    bcs input_loop

check_ip:
    ldx #0           ; Initialize variable
    
check_loop:
    lda address,x    ; Load byte from buffer
    cmp #'0'         ; Check if byte is a digit
    bcc invalid_ip  ; If not, IP is invalid
    cmp #'9'
    bcs invalid_ip

    inx
    cpx #16          ; Check if reached end of buffer
    beq valid_ip

    lda address,x    ; Load byte from buffer
    cmp #'.'
    bne continue_check

    inx
    cpx #16          ; Check if reached end of buffer
    bne check_loop

continue_check:
    lda address,x    ; Load byte from buffer
    cmp #'0'         ; Check if byte is a digit
    bcc invalid_ip
    cmp #'9'
    bcs invalid_ip

    inx
    cpx #16          ; Check if reached end of buffer
    beq valid_ip

    lda address,x    ; Load byte from buffer
    cmp #'.'
    bne continue_check

    inx
    cpx #16          ; Check if reached end of buffer
    bne check_loop

valid_ip:
    lda #'V'        ; Print message indicating valid IP
    jsr $ffda
    lda #'A'
    jsr $ffda
    lda #'L'
    jsr $ffda
    sta APPLTXT
    jmp start

invalid_ip:
    lda #'I'        ; Print message indicating invalid IP
    jsr $ffda
    lda #'n'
    jsr $ffda
    lda #'v'
    jsr $ffda
    lda #'a'
    jsr $ffda
    lda #'l'
    jsr $ffda
    jsr $ffda
    lda #'I'
    jsr $ffda
    lda #'P'
    jsr $ffda
    sta APPLTXT
    jmp start

    .end start
