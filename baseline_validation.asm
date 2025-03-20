
; Random Alphanumeric Password Generator

    .text
    .org $0200

start:
    lda #10                ; Set count of characters in password
    sta count

loop:
    jsr random             ; Generate random character
    sta $c000, x           ; Store character in memory
    inx
    inx
    dec count
    bne loop

    lda #'$0'              ; Add null terminator to end of password
    sta $c000, x

end:
    rts

random:
    lda random_seed        ; Load random seed
    asl
    rol random_seed        ; Rotate bits
    adc #$12               ; Add some randomness
    sta random_seed        ; Store new random seed

    and #$3F               ; Mask out upper bits
    clc
    rts

    .res 256               ; Space for password
random_seed: .byte $FF     ; Initial random seed

    .end start
