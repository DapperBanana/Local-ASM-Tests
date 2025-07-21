
; Fantasy Sports Manager Game

.ORG $8000

START:
  CLD
  LDX #0
  STX PLAYERS
  JSR PRINT_MENU
  
LOOP:
  JSR READ_INPUT
  CMP #1
  BEQ DRAFT
  CMP #2
  BEQ SET_LINEUP
  CMP #3
  BEQ SIMULATE_GAME
  CMP #4
  BEQ QUIT
  
  JSR PRINT_MENU
  BRA LOOP

DRAFT:
  JSR PRINT_DRAFT_MENU
  JSR READ_INPUT
  
  ; Add drafted player to the lineup
  LDA #1
  STA PLAYERS
  BRA LOOP
  
SET_LINEUP:
  JSR PRINT_LINEUP_MENU
  BRA LOOP
  
SIMULATE_GAME:
  JSR PRINT_GAME_RESULTS
  BRA LOOP

PRINT_MENU:
  LDA #0
  JSR PRINT_NEWLINE
  LDA #"Fantasy Sports Manager"
  JSR PRINT_STRING
  JSR PRINT_NEWLINE
  LDA #1
  JSR PRINT_NEWLINE
  LDA #1
  LDX #1
  LDA #"1. Draft Players"
  JSR PRINT_STRING
  LDA #1
  LDX #2
  LDA #"2. Set Lineup"
  JSR PRINT_STRING
  LDA #1
  LDX #3
  LDA #"3. Simulate Game"
  JSR PRINT_STRING
  LDA #1
  LDX #4
  LDA #"4. Quit"
  JSR PRINT_STRING
  RTS

READ_INPUT:
  LDA #"Enter your choice: "
  JSR PRINT_STRING
  LDA #1
  JSR READ_CHAR
  RTS

PRINT_STRING:
  STA $D012
PRINT_LOOP:
  LDA (X),Y
  BEQ PRINT_END
  STA $D013
  JSR DELAY
  INX
  BRA PRINT_LOOP
PRINT_END:
  RTS

PRINT_NEWLINE:
  LDA #$0D
  JSR PRINT_CHAR
  LDA #$0A
  JSR PRINT_CHAR
  RTS

PRINT_DRAFT_MENU:
  LDA #0
  JSR PRINT_NEWLINE
  LDA #"Draft Players Menu"
  JSR PRINT_STRING
  RTS

PRINT_LINEUP_MENU:
  LDA #0
  JSR PRINT_NEWLINE
  LDA #"Set Lineup Menu"
  JSR PRINT_STRING
  RTS

PRINT_GAME_RESULTS:
  LDA #0
  JSR PRINT_NEWLINE
  LDA #"Game Results"
  JSR PRINT_STRING
  RTS

QUIT:
  RTS

DELAY:
  LDX #0
DELAY_LOOP:
  DEX
  BNE DELAY_LOOP
  RTS

; Data Section

PLAYERS: .BYTE 0

; String Data

"Fantasy Sports Manager": .BYTE "Fantasy Sports Manager", 0
"Enter your choice: ": .BYTE "Enter your choice: ", 0
"1. Draft Players": .BYTE "1. Draft Players", 0
"2. Set Lineup": .BYTE "2. Set Lineup", 0
"3. Simulate Game": .BYTE "3. Simulate Game", 0
"4. Quit": .BYTE "4. Quit", 0
"Draft Players Menu": .BYTE "Draft Players Menu", 0
"Set Lineup Menu": .BYTE "Set Lineup Menu", 0
"Game Results": .BYTE "Game Results", 0

.END
