
; Check if a given matrix is a magic square

    processor 6502

    ; Define constants
    SCREENOUT .equ $ffd2  ; Screen output routine
    SCREENOUTSTR .equ $ffd5  ; Screen output string
    GETCHAR .equ $ffd9  ; Get character routine
    CR .equ $0d  ; Carriage return character

    ; Define matrices
    .section .data
matrix .byte 3, 4, 9
    .byte 8, 1, 6
    .byte 4, 7, 2


    ; Start of program
    .section .text
    .org $1000

start:
    ldx #0  ; Initialize X register to 0
    lda #0  ; Initialize accumulator to 0

check_rows:
    ; Check rows
    lda #0  ; Initialize accumulator to 0
    ldy #0  ; Initialize Y register to 0
    lda matrix,x  ; Load first element of row into accumulator

row_loop:
    iny  ; Increment Y register
    clc  ; Clear carry flag
    adc matrix,y  ; Add next element of row to accumulator
    cpy #2  ; Check if end of row
    bne row_loop  ; Repeat loop if not end of row

    cmp #15  ; Compare sum to magic sum (15 for a 3x3 magic square)
    bne not_magic_square  ; Branch if not a magic square

    inx  ; Move to next row
    cpx #2  ; Check if all rows have been checked
    bne check_rows  ; Repeat loop if not all rows checked

is_magic_square:
    lda #"Y"  ; Load "Y" into accumulator (indicates magic square)
    jsr SCREENOUT  ; Call screen output routine
    jmp end  ; End program

not_magic_square:
    lda #"N"  ; Load "N" into accumulator (indicates not a magic square)
    jsr SCREENOUT  ; Call screen output routine
    jmp end  ; End program

end:
    rts  ; Return from subroutine

    ; End of program
