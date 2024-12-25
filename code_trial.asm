
        .org $0200

start   lda str     ; Load address of the string into Accumulator
        sta ptr

        ldy #$00     ; Initialize counter for periods
        ldx #$00     ; Initialize index for string

loop    lda ptr, x  ; Load character from string into Accumulator
        cmp #$2E    ; Check if character is a period
        beq period   ; Branch if period
        cmp #$2F    ; Check if character is a digit
        bcc invalid  ; Branch if not a digit
        cmp #$3A
        bcs invalid

        inx          ; Move to next character in string
        cpx #$0A     ; Check if end of string
        beq valid    ; Branch if end of string
        bne loop

period  iny          ; Increment period counter
        inx          ; Move to next character in string
        cpx #$0A     ; Check if end of string
        beq invalid  ; Branch if end of string
        bne loop

valid   cpy #$03     ; Check if there are 3 periods
        bne invalid  ; Branch if not enough periods
        lda #$01     ; Set flag to indicate valid IPv4 address
        sta result

invalid lda result   ; Load flag indicating result
        rts

result  .byte $00     ; Result flag
ptr     .word 0       ; Pointer to string
str     .byte "192.168.1.1", $00

        .end
