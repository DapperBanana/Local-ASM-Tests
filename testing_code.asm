
; Edit distance calculation program in 6502 Assembly

        .org $0200

start:
        lda #0             ; Initialize distance counter
        sta distance

        ldx #0             ; Initialize index counter
        stx string1_idx

load_next_char1:
        lda string1, x     ; Load next character from string1
        cmp #$00           ; Check for null terminator
        beq string1_done   ; If null terminator, end of string1

        ldy #0             ; Initialize inner loop index counter
        stx string2_idx

load_next_char2:
        lda string2, y     ; Load next character from string2
        cmp #$00           ; Check for null terminator
        beq string2_done   ; If null terminator, end of string2

        cmp string1, x     ; Compare characters from string1 and string2
        beq characters_match
        inc distance       ; Increment distance counter

characters_match:
        iny                ; Increment inner loop index counter
        inx                ; Increment outer loop index counter
        bne load_next_char2

string2_done:
        jmp load_next_char1

string1_done:
        lda distance       ; Load final edit distance
        ; Output edit distance here

        rts

distance:
        .byte 0

string1_idx:
        .byte 0

string2_idx:
        .byte 0

string1:
        .asciiz "hello"

string2:
        .asciiz "world"

        .org $0300
