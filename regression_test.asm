
        .text
start:
        lda #0         ; Initialize counter
        sta counter
        ldx #0         ; Initialize index
        lda str,x      ; Load first character of the string
check_loop:
        beq end_check  ; If end of string then exit
        cmp #$20       ; Check for space
        beq invalid    ; If space found, url is invalid
        cmp #$2F       ; Check for /
        beq invalid    ; If / found, url is invalid
        cmp #$3A       ; Check for :
        beq invalid    ; If : found, url is invalid
        inx            ; Increment index
        cpx #$FF       ; Check if index is at end of string
        beq valid      ; If end of string reached, url is valid
        lda str,x      ; Load next character of the string
        bne check_loop ; Continue looping until end of string

valid:
        lda #1         ; Set flag to indicate valid URL
        jmp end_check

invalid:
        lda #0         ; Set flag to indicate invalid URL

end_check:
        jsr end_program ; End the program

end_program:
        brk

        .data
counter:
        .byte 0
str:
        .asciiz "https://www.example.com"
