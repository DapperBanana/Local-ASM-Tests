
        .org $200

; Matrix data
MATRIX  .byte 2, 9, 4
        .byte 7, 5, 3
        .byte 6, 1, 8

; Constants
ROWS    =   3
COLS    =   3

        lda #<MATRIX    ; Load low byte of matrix pointer
        sta $00          ; Store in memory location $00
        lda #>MATRIX    ; Load high byte of matrix pointer
        sta $01          ; Store in memory location $01

; Check rows
        ldx #0          ; Initialize row index
CHECK_ROWS:
        lda $00          ; Load low byte of matrix pointer
        clc              ; Clear carry flag
        adc ROWS         ; Add the number of rows
        sta $00          ; Store row pointer
        lda $01          ; Load high byte of matrix pointer
        bcc .skip         ; Skip if no page crossing
        inc $00          ; Increment page
.skip:
        lda $00,x        ; Load first element in current row
        clc              ; Clear carry flag
        adc $00,x+ROWS   ; Add second element in current row
        clc              ; Clear carry flag
        adc $00,x+2*ROWS ; Add third element in current row
        bne .not_magic   ; Branch if not equal to zero
        inx              ; Increment row index
        cpx ROWS         ; Check if all rows have been processed
        bne CHECK_ROWS   ; Loop back if not all rows have been checked

; Check columns
        ldx #0          ; Initialize column index
CHECK_COLS:
        lda $00,x        ; Load first element in current column
        clc              ; Clear carry flag
        adc $00,x+COLS   ; Add second element in current column
        clc              ; Clear carry flag
        adc $00,x+2*COLS ; Add third element in current column
        bne .not_magic   ; Branch if not equal to zero
        inx              ; Increment column index
        cpx COLS         ; Check if all columns have been processed
        bne CHECK_COLS   ; Loop back if not all columns have been checked

; Check diagonals
        lda $00          ; Load low byte of matrix pointer
        lda $00,x        ; Load first element in main diagonal
        clc              ; Clear carry flag
        adc $00+(ROWS+1) ; Add second element in main diagonal
        clc              ; Clear carry flag
        adc $00+(2*ROWS+2) ; Add third element in main diagonal
        bne .not_magic   ; Branch if not equal to zero

        lda $00+2        ; Load third element in main diagonal
        clc              ; Clear carry flag
        adc $00+(ROWS-1) ; Add first element in anti-diagonal
        clc              ; Clear carry flag
        adc $00+(2*ROWS) ; Add second element in anti-diagonal
        bne .not_magic   ; Branch if not equal to zero

        lda #$01          ; Load magic square flag (1)
        bra .end         ; Branch to end

.not_magic:
        lda #$00          ; Load magic square flag (0)

.end:
        sta $02          ; Store result in memory location $02

        lda #$00
        sta $02

        rts             ; Return from subroutine
