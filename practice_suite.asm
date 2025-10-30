
        .org $1000

CHECK_JSON:
        lda #$00        ; Initialize accumulator to 0
        sta $2000       ; Clear result memory location

        ldx #$00        ; Initialize index to 0
LOOP:
        lda $1000,X     ; Load character from input string
        cmp #$7B        ; Check if character is '{'
        beq VALID_JSON  ; Branch if it is

        cmp #$7D        ; Check if character is '}'
        beq VALID_JSON  ; Branch if it is

        cmp #$5B        ; Check if character is '['
        beq VALID_JSON  ; Branch if it is

        cmp #$5D        ; Check if character is ']'
        beq VALID_JSON  ; Branch if it is

        cmp #$22        ; Check if character is '"'
        beq QUOTE_CHECK ; Branch to check for quoted string

        inx             ; Increment index
        cpx #$FF        ; Check if end of string
        beq END_LOOP    ; Branch if it is
        jmp LOOP        ; Continue looping

QUOTE_CHECK:
        inx             ; Increment index
        lda $1000,X     ; Load next character
        cmp #$22        ; Check if character is '"'
        beq VALID_JSON  ; Branch if it is
        inx             ; Increment index
        cpx #$FF        ; Check if end of string
        beq END_LOOP    ; Branch if it is
        jmp QUOTE_CHECK  ; Continue checking for quoted string

VALID_JSON:
        lda #$01        ; Set result to 1 (valid JSON)
        sta $2000

END_LOOP:
        rts             ; Return from subroutine
