
ORG $1000

LDA #$00        ; Clear the screen
STA $0400
LDA #$20
LDX #$20
L1: STA $0401,X
DEX
BPL L1

JSR INIT_RANDOM  ; Initialize random number generator seed

LDA #$20        ; Set up crossword puzzle grid
LDX #$00
LDA #$20
L1: STA GRID,X
INX
CPX #$FF
BNE L1

LDA #$20        ; Fill in random letters
LDX #$00
L2: JSR GET_RANDOM
AND #$0F
ORA #$41
STA GRID,X
INX
CPX #$FF
BNE L2

LDA #$00        ; Print crossword puzzle grid
STA $D020
LDX #$00
L3: LDA GRID,X
JSR PRINT_CHAR
INX
CPX #$FF
BNE L3

BRK

INIT_RANDOM:
LDA #$01
STA RAND_SEED
RTS

GET_RANDOM:
LDA RAND_SEED
ASL
ROR
ROR
ROR
STA RAND_SEED
RTS

GRID:
.DEF $FF

PRINT_CHAR:
STA $D020
LDA #$93
STA $D015
LDA #$80
STA $D016
RTS
