
; Social Media Platform Simulator

ORG $0200

START:
  LDA #0
  STA $FB
  LDX #0
  LDA MSG,X
  CMP #0
  BEQ END
LOOP:
  JSR PRINT
  INX
  LDA MSG,X
  CMP #0
  BNE LOOP
END:
  RTS

PRINT:
  STA $FA
  LDA $FA
  STA $F1
  STA $FB
  LDA (0,X)
  CMP #0
  BEQ DONE
  JSR $FFD2
  INX
  JMP PRINT
DONE:
  RTS

MSG:
  .ASCII "Welcome to our Social Media Platform.\0"
  .BYTE 0
  
  .END START
