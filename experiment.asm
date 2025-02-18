
    .org $1000
start:
    sei             ; Disable interrupts
    cld             ; Clear decimal mode
    ldx #$00        ; Initialize loop counter X
    lda #$00        ; Initialize random seed
loop:
    jsr random      ; Get random number
    sta $D020,x     ; Set color of pixel
    inx             ; Increment X
    inc $d800       ; Move to next screen line
    bne loop        ; Repeat until the full screen is colored
    lda #$ff
    sta $d020
    lda #$ff
    sta $d800
    rts

random:
    asl             ; Shift the random seed
    rol $d020       ; Roll it into the least significant bit
    rts             ; Return with the new random value
    
    .org $fffc
    .word start     ; Program entry point
