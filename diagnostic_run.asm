
        .org $0600
start   lda #10         ; Set n = 10
        sta $00         ; Store n in memory location $00
        lda #0          ; Initialize sum to 0
        sta $01         ; Store sum in memory location $01

loop    lda $00         ; Load n
        beq end         ; If n = 0, goto end
        clc             ; Clear carry flag
        adc $01         ; Add n to sum
        sta $01         ; Store updated sum
        dec $00         ; Decrement n
        jmp loop        ; Repeat loop

end     lda $01         ; Load final sum
        jmp $FFD2       ; Exit program

        .org $FFD2
        rti
