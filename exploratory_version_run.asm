
; 6502 Assembly program to generate a random image
; Set the screen mode to graphics mode and generate random pixels
; Assume the screen memory starts at $0400

        .segment "CODE"
        .org $1000

start:
        ; Set the screen mode to graphics mode
        lda #$0d            ; Set graphics mode (GR.0)
        sta $d011           ; VIC-II Control Register 1

        lda #$20            ; Start filling screen memory from $0400
        ldy #$00            ; Y position (row)
loop:
        lda #<rand          ; Load the low byte of the random function address
        ldy #>rand          ; Load the high byte of the random function address
        jsr $ffd2           ; Call the random function

        sta $0400,y         ; Set pixel color at memory location ($0400 + row)
        iny                 ; Move to the next row
        bne loop            ; Loop until all rows are filled

done:
        jmp done            ; End of program

rand:
        lda $d012           ; Get the current rasterline value
        ror                 ; Rotate right to generate a random number
        ror
        ror
        ror
        ror
        ror
        ror
        ror
        ror                 ; Rotate right one more time for good measure
        rts                 ; Return from subroutine
