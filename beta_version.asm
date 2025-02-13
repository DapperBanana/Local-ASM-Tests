
    .nes
    .bank 0

    .org $8000
start:
    lda #0         ; Initialize index
    sta index
    lda #0         ; Initialize character
    sta character
  
loop:
    lda input, x   ; Load next character from input string
    sta character
  
    cmp #46    ; Check if character is equal to '.'
    beq next_char
  
    lda index   ; Check if index is greater than 0 (not first period)
    cmp #0
    beq invalid_token

    inc index   ; Increment index
    cpx #length
    bne loop
  
valid_token:
    lda #0xff  ; Set return value to 0xff (valid token)
    rts
  
invalid_token:
    lda #0x00  ; Set return value to 0x00 (invalid token)
    rts
  
next_char:
    inc x     ; Move to next character
    cpx #length
    bne loop
  
    jmp valid_token ; If we reached the end of the string, it is a valid token

input: 
    .byte "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIn0.Wx5gaaR2HEiQVH1j3n2vAD-7HrXz5Ua2UqU09j-W88c", 0
length = *-input

index:   .byte 0
character: .byte 0
  
    .end
