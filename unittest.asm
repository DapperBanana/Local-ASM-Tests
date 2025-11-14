
        .org $0200

start   lda #$00           ; Initialize accumulator
        ldx #$00           ; Initialize index register
        ldy #$00           ; Initialize index register

readLoop
        ldx #$00           ; Initialize index register
readData
        ldy #$00           ; Initialize index register

        ; Open the file "data.txt" for reading
        ldx #$02           ; File mode: Read
        jsr $FFD5          ; Open file

        ; Read a byte from the file
        jsr $FFCD          ; Read byte
        bcc checkEnd       ; Branch on carry clear (end of file)

        clc                ; Clear carry flag
        adc $00             ; Add value to accumulator
        jmp readData       ; Continue reading

checkEnd
        cpx #$27           ; Check if end of file marker
        bne readLoop       ; Branch if not end of file

        ; Print the sum of all numbers
        sta $01             ; Store accumulator in memory
        lda $01             ; Load accumulator with stored value
        jsr $FFD2          ; Print number

end     rts

data    .incbin "data.txt"

        .end
