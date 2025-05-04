
; Input strings
String1        .byte   "kitten",0
String2        .byte   "sitting",0

; Buffer for dynamic programming matrix
Matrix         .res    7*7

; Main program
  .org  $0200

  lda   #$00
  sta   $3F00
  sta   $FE03
  ldx   #$00      ; Loop counters
  ldy   #$00

start:
  lda   String1,X ; Load characters from String1 and String2
  sta   $3F00,X
  lda   String2,X
  sta   $FE03,X
  inx
  iny
  cpy   #$07
  bne   start

  lda   #$01
  tay
  ldx   #$01

loop1:
  lda   #$01
  sta   Matrix,X
  ldy   #$01
  inx
  ldx   $FE03
  lda   #$01
  sta   Matrix,X

loop2:
  lda   Matrix-1,Y   ; Load values from matrix
  sta   $FF00         ; Store them in registers for calculations
  lda   Matrix-7,Y
  sta   $FF01

  lda   Matrix-8,Y
  cpx   #$07
  beq   skipdiag
  
  lda   Matrix-8,Y
  sec
  sbc   Matrix,Y
  cmp   #$01
  beq   updatediag

  lda   Matrix-1,Y
  sec
  sbc   #$01
  bcs   skipdiag

updatediag:
  iny
  lda   Matrix-8,Y
  adc   #$01
  sta   Matrix,X

skipdiag:
  lda   Matrix-1,Y
  adc   #$01
  sta   Matrix,X

  dey
  cpy   #$07
  bne   loop2
  lda   Matrix,X
  sec
  sbc   #$01
  sta   Matrix,X

  dey
  cpy   #$07
  bne   loop1

  lda   Matrix-1
  sta   $FF00
  lda   Matrix,Y
  sta   $FF01

  lda   #$FE
  sta   $FF02
  jsr   $FFD2

  rts
