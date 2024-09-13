
ORG $0600

START:
  SEI
  CLD
  LDX #0
  LDY #0
  LDA #0
  JSR INIT_BOARD
  
MAIN_LOOP:
  JSR DRAW_BOARD
  JSR GET_MOVE
  JSR UPDATE_BOARD
  JSR CHECK_WIN
  BNE MAIN_LOOP
  
  RTS
  
INIT_BOARD:
  LDY #0
CLEAR_ROW:
  STY BOARD,X
  INY
  CPY #3
  BNE CLEAR_ROW
  
  RTS
  
DRAW_BOARD:
  LDA #0
  JSR $FFD2  ; Clear screen
  
  LDX #0
CLEAR_LINE:
  LDA #32  ; ASCII space character
  LDY #0
PRINT_ROW:
  LDA BOARD,X
  CMP #0
  BEQ PRINT_SPACE
  CPY #2
  BNE PRINT_X
PRINT_O:
  LDA #79  ; ASCII letter 'O'
  JMP PRINT_CHAR
PRINT_X:
  LDA #88  ; ASCII letter 'X'
PRINT_CHAR:
  JSR $FFD2  ; Print character
PRINT_SPACE:
  JSR $FFD2  ; Print space
  INY
  CPY #3
  BNE PRINT_ROW
  
  INX
  CPX #3
  BNE CLEAR_LINE
  
  RTS
  
GET_MOVE:
  LDA #69  ; ASCII letter 'E'
  JSR $FFD2  ; Print prompt
  
  JSR $FFCC  ; Input character
  SEC
  SBC #48  ; Convert ASCII digit to number
  RTS
  
UPDATE_BOARD:
  STA TEMP
  LDA MOVE
  ASL  ; Multiply by 2 for array index
  TAY
  LDA TEMP
  JSR $FFD2  ; Print move
  
  LDA #1
  STA BOARD,Y
  
  RTS
  
CHECK_WIN:
  JMP CHECK_ROWS
CHECK_ROWS:
  LDY #0
ROW_LOOP:
  LDA BOARD,Y
  CMP BOARD+1,Y
  BEQ NEXT_ROW
  LDA BOARD,Y
  CMP BOARD+2,Y
  BEQ WIN
NEXT_ROW:
  INY
  CPY #3
  BNE ROW_LOOP
  
  RTS
  
WIN:
  LDA #87  ; ASCII letter 'W'
  JSR $FFD2  ; Print congratulations message
  RTS
  
BOARD:
  .BYTE 0, 0, 0
  .BYTE 0, 0, 0
  .BYTE 0, 0, 0
  
MOVE:
  .BYTE 0
  
TEMP:
  .BYTE 0
  
  .END
