
; 6502 Assembly program for basic file compression algorithm

    .org $1000  ; start address

start:
    lda #0     ; clear accumulator
    sta $0400  ; clear memory location for input buffer
    sta $0401  ; clear memory location for output buffer
    
read_input:
    lda $input_buffer, x  ; load next byte from input buffer
    beq end_of_input      ; check for end of input
    
    ; compression algorithm
    cmp $0402  ; compare current byte with next byte
    beq duplicate_byte  ; if they are the same, they are duplicates
    
    ; if not duplicates, store current byte in output buffer
    sta $output_buffer, y
    inc y  ; increment output buffer index
    
    duplicate_byte:
    inc $0402  ; increment count of duplicate bytes
    
    ; move to next byte in input buffer
    inx
    jmp read_input
    
end_of_input:
    lda #0
    sta $0402  ; clear duplicate byte count
    
    ; output compressed data
    lda $output_buffer, x
    beq done
    
    ; output remaining bytes in output buffer
    sta $output_address, x
    jmp done
    
done:
    rts
    
input_buffer:
    .byte $12, $34, $56, $56, $78, $AB, $CD, $EF, $00

output_buffer:
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0

output_address:
    .byte $0800 ; output memory address
