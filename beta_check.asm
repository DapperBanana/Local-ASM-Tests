
; Program to check if a given matrix is a magic square
; Accepts a 3x3 matrix starting at memory address $2000
; Returns 1 if the matrix is a magic square, 0 otherwise

        .org $0200     ; Start program at address $0200

start:
        lda #$30       ; Load matrix counter 0
        sta $01        ; Store matrix counter in memory location $01

check_sum:
        lda $2000,X    ; Load value from matrix
        clc
        adc $2003,X    ; Add value from same row but different column
        adc $2006,X    ; Add value from same row but different column
        cmp $200C,X    ; Compare with expected sum
        beq next_row   ; If sum matches, proceed to next row

no_magic_square:
        lda #$00       ; Load 0 to indicate not a magic square
        jmp end

next_row:
        inc $01        ; Increment matrix counter
        lda $01
        cmp #$03       ; Check if all rows have been checked
        beq check_columns

        lda $01
        asl            ; Shift left to calculate row offset
        asl
        asl
        clc
        adc #$02       ; Add 2 to get next row start address
        sta $01

        lda #$00       ; Reset sum accumulator
        jmp check_sum

check_columns:
        lda $2000     ; Load first element for column check
        clc
        adc $2004     ; Add value from same column but different row
        adc $2008     ; Add value from same column but different row
        cmp $200C     ; Compare with expected sum
        beq check_diagonal

        jmp no_magic_square

check_diagonal:
        lda $2000     ; Load first element for diagonal check
        clc
        adc $2005     ; Add second diagonal element
        adc $200A     ; Add third diagonal element
        cmp $200F     ; Compare with expected sum
        beq is_magic_square

        jmp no_magic_square

is_magic_square:
        lda #$01     ; Load 1 to indicate magic square
        jmp end

end:
        rts           ; Return from subroutine

        .org $2000    ; Start address for 3x3 matrix
matrix:
        .byte $01, $02, $03
        .byte $04, $05, $06
        .byte $07, $08, $09
