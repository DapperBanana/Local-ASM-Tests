
        .org $1000

start   lda #$00            ; Initialize index to 0
        sta index

loop    lda input, x        ; Load character from input string
        cmp #$00            ; Check if end of string
        beq end

        cmp #$2d            ; Check for hyphen character
        beq skip

        and #$df            ; Convert lowercase letters to uppercase
        cmp #$30            ; Check for digit
        bcc invalid         ; If not a digit, it is invalid

        jsr multiply        ; Multiply digit by its position
        jsr add             ; Add result to total
        inc index           ; Increment index
        bcc next            ; Branch if no carry
        inc index+1         ; Increment high byte of index

next    inx                 ; Increment x register
        bne loop            ; Repeat loop
        lda total           ; Load total
        cmp #$00            ; Check if total is divisible by 11
        beq valid           ; If total is 0, it is valid

invalid lda #$00            ; Clear index
        sta index
        jmp end             ; Jump to end

valid   lda #$01            ; Set flag to show it is valid
        sta flag

end     rts

multiply
        asl                 ; Multiply digit by 2
        rol total           ; Rotate result to high byte
        rts

add     clc                 ; Clear carry
        lda total           ; Load total
        adc input, x        ; Add result to total
        sta total           ; Store result
        rts

input   .byte "0-13-703235-5", 0

index   .byte 0
flag    .byte 0
total   .word 0

        .end
