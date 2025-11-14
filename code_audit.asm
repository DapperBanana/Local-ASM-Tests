
        .org $0200

; Start of program
start:
        lda #0        ; Initialize index
        sta index
loop:
        lda input, x  ; Load character from input string
        beq end       ; Check for end of string
        cmp #"A"      ; Check if character is a letter
        bcc invalid   ; If not, string is invalid
        cmp #"z"
        bcs invalid
        cmp #"0"      ; Check if character is a number
        bcc invalid
        cmp #"9"
        bcs valid_char
        cmp #"."      ; Check if character is a period
        beq valid_char
        cmp #":"
        beq valid_char
        cmp #"/"
        beq valid_char
        bcs invalid

valid_char:
        inx           ; Increment index
        cpx #strlen   ; Check if end of string
        bne loop      ; If not, continue looping
        bne valid     ; If end of string, string is valid

invalid:
        lda #0        ; Set result to 0 (invalid)
        jmp end

valid:
        lda #1        ; Set result to 1 (valid)

end:
        rts

; Input string
input:
        .byte "http://www.example.com",0
strlen = * - input   ; Length of input string

index:
        .byte 0

        .end
