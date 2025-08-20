
ORG $1000
start:
  ldx #0
next_byte:
  lda input_buffer,x
  beq end_of_file
  sta current_byte
  
check_repetition:
  lda input_buffer,x
  beq end_of_file
  cmp current_byte
  bne next_byte
  inx
  bne check_repetition
  
  lda #2
  sta repetition_count
  rts
  
end_of_file:
  lda #0
  sta repetition_count
  rts

input_buffer:
  .byte $AA, $BB, $CC, $DD, $AA, $AA, $FF, $00
current_byte:
  .byte 0
repetition_count:
  .byte 0
