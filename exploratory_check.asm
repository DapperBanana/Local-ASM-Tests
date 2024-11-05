
    .org $0200

start:
    lda #0              ; Initialize counters
    sta count_at
    sta count_dot
    sta valid

loop:
    lda string, x       ; Load next character
    beq end             ; If null terminator, end of string
    
    cmp #'@'
    beq found_at        ; Check for @ symbol
    
    cmp #'.'
    beq found_dot       ; Check for dot symbol
    
    inc count_chars     ; Increment character count
    inc x
    jmp loop

found_at:
    lda count_at        ; Check if @ symbol appears only once
    cmp #1
    bne invalid
    
    inc count_at        ; Increment the @ counter
    inc x
    jmp loop

found_dot:
    lda count_dot       ; Check if dot symbol appears only once after @ symbol
    cmp #1
    bne invalid
    
    inc count_dot       ; Increment the dot counter
    inc x
    jmp loop

invalid:
    lda #0              ; Set valid flag to 0
    sta valid

end:
    rts

    .org $0300

string:
    .asciiz "example@example.com"

    .end
