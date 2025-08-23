
.org $0200

input_buffer .byte $00 ; Input buffer to store uncompressed data
output_buffer .byte $00 ; Output buffer to store compressed data

count .byte $00 ; Count of consecutive bytes
current_byte .byte $00 ; Current byte being processed
prev_byte .byte $00 ; Previous byte

compress:
    lda #0 ; Initialize count to 0
    sta count
    
    ldx #0 ; Initialize index to 0

next_byte:
    lda input_buffer, x ; Load next byte
    cmp prev_byte ; Compare with previous byte
    
    beq increment_count ; If equal, increment count
    
    ; Output count and byte to output buffer
    lda count
    sta output_buffer, x
    inx
    lda prev_byte
    sta output_buffer, x
    inx
    
    ; Update previous byte and count
    lda input_buffer, x
    sta prev_byte
    lda #1
    sta count
    
increment_count:
    inx
    inc count
    
    cpx #256 ; Check if end of buffer
    bne next_byte
    
    rts

.end
