
; 6502 Assembly Chatbot Simulator

        .org $0200

; Define Input/Output locations
KBD = $C000  ; Keyboard input register
SCR = $0400  ; Screen output register
TXT = $0200  ; Text buffer

        .org $FFFC
        .word start

start:
        lda #<input_handler
        sta $0200
        lda #>input_handler
        sta $0201

        lda #<output_handler
        sta $0300
        lda #>output_handler
        sta $0301

        lda #$10
        sta $D020

loop:
        jmp loop

input_handler:
        lda KBD
        sta TXT
        rts

output_handler:
        ldx #$00
        ldy #$00
print_loop:
        lda TXT, y
        beq print_end
        sta SCR, x
        inx
        iny
        bne print_loop
print_end:
        rts
