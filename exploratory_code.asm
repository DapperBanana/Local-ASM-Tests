
        .org $1000

start   lda #$2000      ; Load starting address of input string
        sta $00         ; Store in zero page for easy access

loop    lda ($00),y     ; Load next character from input string
        beq end         ; If end of string, exit loop
        cmp #$61        ; Check if lowercase letter
        bcc notLower    ; If not lowercase, skip conversion
        cmp #$7A        ; Check if above 'z'
        bcs notLower
        and #$DF        ; Convert to uppercase
        sta ($00),y     ; Store back in memory

notLower
        iny             ; Move to next character
        jmp loop

end     lda #$2000      ; Load starting address of input string
        sta $00         ; Store in zero page for easy access
        lda #$3000      ; Load starting address of output string
        sta $01         ; Store in zero page for easy access

copy    lda ($00),y     ; Copy character from input string
        beq complete    ; If end of string, exit loop
        sta ($01),y     ; Store in output string
        iny             ; Move to next character
        jmp copy

complete
        rts

        .org $2000

input   .byte "hello, world!", 0

        .org $3000

output  .byte 16         ; Reserve space for output string
