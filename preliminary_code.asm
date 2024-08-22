
    .org $0800  ; Start program at memory address $0800

start:
    lda #$00
    sta source_ptr   ; Initialize source_ptr to point to the first byte of the input file
    lda #$0400
    sta dest_ptr     ; Initialize dest_ptr to point to the first byte of the output file

compress_loop:
    lda (source_ptr),y    ; Load the next byte from the input file
    sta temp_byte         ; Save the byte in temp_byte

    inc source_ptr        ; Move to the next byte in the input file

    lda (source_ptr),y    ; Load the next byte from the input file
    cmp temp_byte         ; Compare with the previously saved byte

    beq repeat_byte       ; If the bytes are the same, repeat_byte
    bne write_byte        ; If the bytes are different, write_byte

repeat_byte:
    inc repeat_count      ; Increment repeat_count
    lda repeat_count
    cmp #$FF              ; Check if repeat_count has reached maximum limit
    beq write_token       ; If so, write the repeat token

    jmp compress_loop     ; Continue compressing

write_byte:
    lda temp_byte
    sta (dest_ptr),y      ; Write the byte to the output file
    inc dest_ptr          ; Move to the next byte in the output file

    lda #$01
    sta repeat_count      ; Reset repeat_count to 1

    jmp compress_loop     ; Continue compressing

write_token:
    lda temp_byte
    sta (dest_ptr),y      ; Write the repeat token to the output file
    inc dest_ptr          ; Move to the next byte in the output file
    lda #$00
    sta repeat_count      ; Reset repeat_count to 0

    jmp compress_loop     ; Continue compressing

source_ptr:
    .word $0000

dest_ptr:
    .word $0000

repeat_count:
    .byte $00

temp_byte:
    .byte $00

    .end
