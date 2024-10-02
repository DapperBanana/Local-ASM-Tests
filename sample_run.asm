
; 6502 Assembly program to check if a given matrix is a magic square

START:
    ldx #0                 ; Initialize counter to 0
    lda MATRIX,X           ; Load element from matrix at index X
    clc                    ; Clear carry flag
    adc ACC,X              ; Add element to accumulator with carry
    sta ACC,X              ; Store result back in accumulator
    inx                    ; Increment counter
    cpx #SIZE              ; Compare counter to size of matrix
    bne START              ; Loop back if not at end
    bcs IS_MAGIC_SQUARE    ; Branch if accumulator overflows

NOT_MAGIC_SQUARE:         ; Matrix is not a magic square
    lda #NOT_MAGIC_MSG     ; Load message to print
    jsr PRINT_STRING       ; Print message
    rts                    ; Return

IS_MAGIC_SQUARE:          ; Matrix is a magic square
    lda #MAGIC_MSG         ; Load message to print
    jsr PRINT_STRING       ; Print message
    rts                    ; Return

MATRIX:
    .byte 2, 7, 6          ; Example matrix 3x3
    .byte 9, 5, 1
    .byte 4, 3, 8

SIZE = *-MATRIX

MAGIC_MSG:
    .asciiz "Matrix is a magic square\n"

NOT_MAGIC_MSG:
    .asciiz "Matrix is not a magic square\n"

ACC:
    .byte 0

PRINT_STRING:
    lda (PTR),Y            ; Load next character
    beq PRINT_DONE         ; Exit if end of string
    jsr PRINT_CHAR         ; Print character
    iny                    ; Increment index
    jmp PRINT_STRING       ; Loop back

PRINT_DONE:
    rts

PRINT_CHAR:
    ; Routine to print character
