
start:
  lda #$00         ; initialize accumulator
  sta $fb          ; clear memory location
  ldx #$00         ; initialize X register
  sty $fc          ; clear memory location
  ldy #$00         ; initialize Y register

next_row:
  lda #$00         ; initialize accumulator for row
  sta $fc          ; clear memory location for row
  lda #$08         ; set column count to 8
  sta $fd          ; store column count
next_col:
  lda $fb          ; load accumulator with random value
  anda #$0f        ; mask out upper bits to get random number between 0 and 15
  sta ($fc),y      ; store random number in crossword grid
  iny              ; increment Y register
  cpy $fd          ; check if end of column
  bne next_col     ; if not, continue to next column
  inx              ; increment X register
  cpx #$08         ; check if end of row
  bne next_row     ; if not, continue to next row

done:
  rts              ; return from subroutine
