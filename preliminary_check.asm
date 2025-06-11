
; Generate a random password of a given length

    .org $0200  ; start of program

start:
    lda #0      ; clear accumulator
    sta $02     ; initialize random number seed
    lda #10     ; load password length
    sta length

generate_password:
    lda $02     ; load random number seed
    clc
    adc #1      ; increment seed
    sta $02     ; store updated seed

    lda $02     ; load random number seed
    and #15     ; mask to 4 bits
    tax         ; transfer seed to X register
    lda $02     ; load random number seed
    eor $02     ; xor with seed
    ror         ; rotate right
    eor $02     ; xor with seed
    sta $02     ; store updated seed

    lda $02     ; load random number seed
    and #15     ; mask to 4 bits
    clc
    adc #$41    ; add ASCII offset for lowercase letters
    sta password, x ; store character in password

    dex         ; decrement X register
    bpl generate_password ; repeat until all characters generated

done:
    lda #0      ; clear accumulator
    jsr $ffcc   ; call KERNAL routine to print character
    rts         ; return from subroutine

    .byte 0     ; reserve memory for password
length:
    .byte 0     ; reserve memory for password length
