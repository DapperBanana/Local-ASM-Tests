
        .org $0200

start   lda #0
        sta $00           ; clear memory location to store binary number
        
        lda #26          ; load decimal number to convert
        sta $01
        
convert lsr $01           ; shift right and store the carry in memory
        bcc bit0         ; jump if no carry
        ora #$01         ; set the least significant bit
        
bit0    sta $00           ; store the result in memory
        
        cmp #0           ; compare to see if decimal number is 0
        bne convert      ; if not 0, continue conversion
        
        lda $00           ; load binary number to accumulator
        nop               ; do nothing to validate binary number
        
end     jmp end           ; infinite loop

        .end
