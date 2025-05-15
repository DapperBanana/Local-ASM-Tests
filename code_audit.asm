
.org $1000

    lda #$00         ; Initialize accumulator with 0
    ldx #$07         ; Initialize X register with 7 (number of bits - 1)
    
convert_loop:
    lsr              ; Shift right to get the least significant bit
    bcc skip_add     ; If carry bit is not set, skip adding
    clc              ; Clear carry flag
    adc #$01         ; Add 1 to accumulator
skip_add:
    dex              ; Decrement X register
    bpl convert_loop ; If X is still positive, continue loop
    
    ; Output result
    sta $d020        ; Set screen color
    sta $d021        ; Set border color
    ldx #$02         ; Initialize X with 2 for SYS call
    lda #$0b         ; Set video mode
    lda #$00         ; Set screen code to show contents of accumulator
    jsr $ffd2        ; Call Kernal routine to output accumulator
    
end:
    rts              ; Return from subroutine

    .byte $00        ; Unused bytes

