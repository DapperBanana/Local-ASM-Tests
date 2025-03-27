
        .org $0200

start   lda #$00            ; Set up input buffer pointer
        sta $fb
        lda #$01
        sta $fb+1

        lda #$00            ; Set up output buffer pointer
        sta $fa
        lda #$01
        sta $fa+1

read_loop
        lda $fb             ; Read a byte from input file
        jsr read_byte
        beq end_of_file     ; If end of file, exit

        cmp #','
        beq print_newline   ; If comma, print newline
        jsr print_byte      ; Print byte to the screen

        jmp read_loop       ; Continue reading

print_newline
        lda #$0d            ; Print newline character
        jsr print_byte
        lda #$0a
        jsr print_byte

        jmp read_loop       ; Continue reading

end_of_file
        rts                 ; Exit program

read_byte
        lda $fb             ; Read a byte from input file
        ldx $fb+1
        jsr $ffcf           ; OSBYTE SWI

        inx
        stx $fb+1           ; Move pointer to next byte

        rts

print_byte
        sta $fa             ; Print a byte to the screen
        ldx $fa+1
        jsr $ffd2           ; OSWRCH

        inx
        stx $fa+1           ; Move pointer to next byte

        rts

        .end
