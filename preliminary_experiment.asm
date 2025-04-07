
; 6502 Assembly program to generate a random crossword puzzle

 ; Load start of puzzle address into Y register
Start
  LDA #$00    ; Load accumulator with 0
  STA $4000,Y ; Store accumulator in memory at $4000
  INY         ; Increment Y register
  CPY #$40    ; Compare Y register with $40
  BNE Start   ; Branch back to Start if not equal

  LDA $FD00   ; Load random number generator seed
  STA $FD09   ; Store seed in RANDOM number generator seed
  LDA $FD00   ; Load seed
  CLC         ; Clear carry flag
  ADC $FD01   ; Add low byte of RAND to accumulator
  STA $FD00   ; Store new seed in memory
  LDA $FD00   ; Load seed
  BCC Random  ; Branch to Random if no carry
  INC $FD01   ; Increment high byte of RAND

Random
  JSR $FD0A   ; Get random number into accumulator
  AND #$3F    ; Mask out upper 2 bits (have a random number between 0 and 63)
  STA $4000,X ; Store random number in memory at $4000
  INX         ; Increment X register
  CPX #$40    ; Compare X register with $40
  BNE Random  ; Branch back to Random if not equal

  RTS         ; Return from subroutine
