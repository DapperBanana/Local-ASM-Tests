
        .org $0200     ; Set program start address

start:  lda #0         ; Initialize counter
        sta count

        ldx #0         ; Initialize index
        lda input,x    ; Load first character
        beq invalid    ; Check for empty string

loop:   cmp #':'       ; Check for delimiter
        beq delimiter

        cmp #0          ; Check for end of string
        beq end

        inx            ; Increment index
        cpx #MAX_LENGTH ; Check for maximum length
        beq invalid

        lda input,x    ; Load next character
        bne loop

delimiter:
        lda input,x    ; Load next character
        cpx #MIN_GROUP_LENGTH 
        bcs invalid

        lda input,x    ; Load next character
        cmp #':'       ; Check for delimiter
        bne invalid

        inx
        lda input,x    ; Load first character of group
        beq invalid

group_loop:
        cmp #'0'
        lda input,x
        cmp #'9'
        beq group_loop

        ldy #5
        dex
        lda input,x
        cmp #'0'
        bcs invalid
        lda input,x
        cmp #'9'
        bcc invalid

end:    lda #1
        sta result     ; Set result to 1 (valid)
        rts

invalid:
        lda #0
        sta result     ; Set result to 0 (invalid)
        rts

input:  .byte '2','0','0','1',':','1','3','f','f','a','c','\0' ; Input string
count:  .byte 0        ; Counter variable
result: .byte 0        ; Result variable
MAX_LENGTH = 30         ; Maximum length of IPv6 address
MIN_GROUP_LENGTH = 4    ; Minimum length of each group in IPv6 address
