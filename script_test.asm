
.org $0200

STRING_PTR   .asciiz "hello, world"        ; Input string
OUTPUT_BUFFER    .blk 10                    ; Buffer to store the converted string

START
    ldx #0                                  ; Load index register with 0
LOOP
    lda STRING_PTR, x                       ; Load character from input string
    cmp #32                                 ; Check if character is space
    beq CONVERT_UPPERCASE                   ; Branch if character is space
    jsr TOLOWER                             ; Call subroutine to convert to lowercase
    sta OUTPUT_BUFFER, x                    ; Store the converted character in the output buffer
    inx                                     ; Increment index
    cpx #10                                 ; Check if end of string
    bne LOOP                                ; Branch back to LOOP if not end of string

DONE
    brk                                     ; End program

CONVERT_UPPERCASE
    inx                                     ; Skip the space character
    jmp LOOP

TOLOWER
    cmp #65                                 ; Check if character is uppercase
    bcc NOT_UPPERCASE                       ; Branch if not uppercase
    cmp #90                                ; Check if character is within uppercase range
    bcc CONVERT_CHAR                       ; Branch to CONVERT_CHAR if within uppercase range

NOT_UPPERCASE
    rts                                     ; Return from subroutine

CONVERT_CHAR
    sec                                     ; Set the carry flag
    sbc #32                                 ; Subtract 32 to convert to lowercase
    rts                                     ; Return from subroutine

.end
