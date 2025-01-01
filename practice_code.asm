
; Random Password Generator in 6502 Assembly

    .org $0200

start:
    lda #0      ; Initialize random seed
    sta $FB

    ldx #0      ; Initialize password index
    ldy #0      ; Initialize character count

loop:
    lda $FB     ; Get random seed
    clc
    adc #17     ; Add 17 for lowercase letters (a-z)
    cmp #91     ; Check if within range of lowercase letters
    bcc lowercase

    ; If not within range of lowercase letters, subtract 10 to get lowercase letter
    lda $FB
    sec
    sbc #10
    jmp store

lowercase:
    ; Store as lowercase letter
    sta $0400,x
    inx
    inc y

    lda y
    cmp #8      ; Check if password length is 8 characters
    beq done

    ; Generate next random number
    lda $FB
    sta $05

    ; Get random seed
    lda $FB
    
    clc
    adc #10     ; Add 10 for numbers (0-9)
    cmp #58     ; Check if within range of numbers
    bcc store

    ; If not within range of numbers, subtract 26 to get number
    lda $FB
    sec
    sbc #26

store:
    ; Store as number
    sta $0400,x
    inx
    inc y

    lda y
    cmp #8      ; Check if password length is 8 characters
    beq done

    ; Generate next random number
    lda $FB
    sta $FB

    ; Get random seed
    lda $FB
    ror a       ; Rotate right to generate pseudo-random number
    
    ; Repeat loop for next character of password
    jmp loop

done:
    ; End program
    brk

    ; Password storage area
    .org $0400
    .block $0008
