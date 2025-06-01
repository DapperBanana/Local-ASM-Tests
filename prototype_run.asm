
ROM_START = $6000
RAM_START = $0200

INIT:
  SEI
  LDX #$FF
  TXS
  TXA
  STX $4017
  LDX #$00
  STX $2000
  STX $2001
  STX $2005
  STX $2006
  
  ; Initialize the maze
  JSR INIT_MAZE
  
  ; Generate the random maze
  JSR GENERATE_MAZE
  
  ; Solve the maze using depth-first search
  JSR DEPTH_FIRST_SEARCH
  
  ; Infinite loop
  JMP *
  
INIT_MAZE:
  LDA #$00
  STA $0200, X
  INX
  CPX #$64
  BNE INIT_MAZE
  
  RTS

GENERATE_MAZE:
  LDX #$00
  STX $00
  STX $01
  STX $02
  STX $03
  
  LDA #$01
  STA $04
  
  LDA #$FF
  STA $02
  STA $03
  
  LDA #$00
  STA $00
  STA $01
  
  JSR RANDOM
  
  AND #$03
  STA $05
  
  STA $06
  
  LDA #$00
  STA $07
  
  LDA #$08
  STA $08
  
  LDA #$00
  STA $09
  STA $0A
  
LOOP:
  DEC $0A
  BEQ BACK
  
  LDA $0A
  ASL
  STA $0B
  
  LDA $05
  ADC $0B
  STA $0B
  
  JSR DRAW
  
  JMP BACK1
  
BACK:
  LDA $0A
  AND #$01
  BEQ INCR
  
  LDA $06
  STA $08
  
  JMP CONTINUE
  
INCR:
  LDA $05
  STA $06
  
BACK1:
  LDA $0A
  LSR
  STA $0A
  
  LDA $06
  CMP $07
  BCC LOOP
  
  LDA $0A
  AND #$01
  BEQ AND1
  
  LDA $06
  STA $07
  
AND1:
  LDA $06
  AND $09
  CMP #$08
  BCC CONTINUE
  
  LDA $0A
  STA $09
  JSR RANDOM
  AND #$03
  STA $05
  
  STA $06
  
  LDA #$00
  STA $07
  
  LDA #$08
  STA $08
  
CONTINUE:
  LDA $00
  ORA $01
  STA $0D
  
  LDA $0D
  ORA $04
  STA $0E
