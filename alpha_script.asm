
    .org    $2000
start:
    lda     #1
    sta     $d020     ; Set border color to white
    ldx     #0
    
loop:
    lda     $dc0d     ; Read random number from hardware
    and     #15       ; Limit the random number to 0-15
    sta     $0400,x   ; Write random number to screen memory
    inx
    cpx     #$400
    bne     loop

    lda     #0
    sta     $01       ; Disable VIC-II chip to show the image
    lda     #1
    sta     $d011     ; Disable interrupts to prevent screen flicker

    rts

    .org    $0314
    .word    start
