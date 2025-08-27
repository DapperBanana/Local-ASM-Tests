
; Program to remove duplicates from a list while preserving the order

; Input: List of numbers in memory starting from address 0x0200 with a terminating
;        byte 0xFF
; Output: List with duplicates removed, stored in memory starting from address 0x0400

.org $0200

start:
  ldx #$00 ; initialize index of current element
  lda $0200,x ; load first element into accumulator
  
loop:
  cmp #$FF ; check for termination byte
  beq done ; if termination byte, exit loop
  
  ; check for duplicates
  lda $0200,x ; load current element into accumulator
  lda $0200,x ; load same element again
  cmp $0200,x ; compare with next element
  beq skip ; if duplicate, skip current element
  
  sta $0400,x ; if not duplicate, store element in output list
  
skip:
  inx ; increment index
  jmp loop ; repeat loop
  
done:
  lda #$FF ; store termination byte in output list
  sta $0400,x ; store termination byte
  rts ; return from subroutine

