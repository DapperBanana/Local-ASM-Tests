
; Fitness tracking system program

; Data
.data
current_step_count .byte 0
goal_step_count .byte 10000

.text
; Entry point
.org $0800
start:
  jsr print_menu
  jmp start

print_menu:
  lda #'F'
  jsr putc
  lda #'I'
  jsr putc
  lda #'T'
  jsr putc
  lda #'N'
  jsr putc
  lda #'E'
  jsr putc
  lda #'S'
  jsr putc
  lda #'S'
  jsr putc
  lda 'T'
  jsr putc
  lda 'R'
  jsr putc
  lda 'A'
  jsr putc
  lda 'C'
  jsr putc
  lda 'K'
  jsr putc
  lda 'I'
  jsr putc
  lda 'N'
  jsr putc
  lda 'G'
  jsr putc
  lda 'S'
  jsr putc
  lda 'Y'
  jsr putc
  lda 'S'
  jsr putc
  lda 'T'
  jsr putc
  lda 'E'
  jsr putc
  lda 'M'
  jsr putc
  lda 'M'
  jsr putc
  lda 'A'
  jsr putc
  lda ':'
  jsr putc
  lda #$0D
  jsr putc

  lda #'1'
  jsr putc
  lda ' '
  jsr putc
  lda 'S'
  jsr putc
  lda 't'
  jsr putc
  lda 'e'
  jsr putc
  lda 'p'
  jsr putc
  lda 's'
  jsr putc
  lda ' -'
  jsr putc
  lda ' 5'
  jsr putc
  lda '0'
  jsr putc
  lda '0'
  jsr putc
  lda '0'
  jsr putc
  lda '0'
  jsr putc
  lda ' '
  jsr putc
  lda 'G'
  jsr putc
  lda 'o'
  jsr putc
  lda 'a'
  jsr putc
  lda 'l'
  jsr putc
  lda ':'
  jsr putc
  lda current_step_count
  jsr putnum
  lda ' '
  jsr putc
  lda '/'
  jsr putc
  lda ' '
  jsr putc
  lda goal_step_count
  jsr putnum
  lda #$0D
  jsr putc

  lda #'2'
  jsr putc
  lda ' '
  jsr putc
  lda 'E'
  jsr putc
  lda 'x'
  jsr putc
  lda 'i'
  jsr putc
  lda 't'
  jsr putc
  lda ' '
  jsr putc
  lda 'P'
  jsr putc
  lda 'r'
  jsr putc
  lda 'o'
  jsr putc
  lda 'g'
  jsr putc
  lda 'r'
  jsr putc
  lda 'a'
  jsr putc
  lda 'm'
  jsr putc
  lda ':'
  jsr putc
  lda #$0D
  jsr putc

  lda #'3'
  jsr putc
  lda ' '
  jsr putc
  lda 'Q'
  jsr putc
  lda 'u'
  jsr putc
  lda 'i'
  jsr putc
  lda 't'
  jsr putc
  lda #'Q'
  jsr putc
  lda 'u'
  jsr putc
  lda 'i'
  jsr putc
  lda 't'
  jsr putc
  lda #$0D
  jsr putc

  lda #'4'
  jsr putc
  lda ' '
  jsr putc
  lda 'E'
  jsr putc
  lda 'x'
  jsr putc
  lda 'i'
  jsr putc
  lda 't'
  jsr putc
  lda '#'
  jsr putc
  lda current_step_count
  jsr putnum
  lda #$0D
  jsr putc

  lda #$00
  rts

putnum:
  ; Divide by 10 until the number is 0
  ldx #$0A
loop:
  lda #$00
  cmp #$00
  beq exit
  dex
  ror
  tax
  jmp loop
exit:
  rts

putc:
  jsr $ffd2
  rts
