
.INCLUDE "6502.h"

; Constants
PLAYER_START_X = $10
PLAYER_START_Y = $10
MAP_WIDTH = $10
MAP_HEIGHT = $10

; Variables
playerX = $00
playerY = $00
mapData = $0100

START:
    LDA PLAYER_START_X
    STA playerX
    LDA PLAYER_START_Y
    STA playerY

GAME_LOOP:
    PRINT "Player Position: ("
    JSR PRINT_NUMBER ; print player's X position
    PRINT ", "
    JSR PRINT_NUMBER ; print player's Y position
    PRINT ")"
    PRINTN

    LDA mapData, X
    CMP #0
    BEQ NO_PLANET

    JSR ENTER_PLANET

NO_PLANET:
    JSR GET_INPUT
    JSR MOVE_PLAYER

    JMP GAME_LOOP

; Subroutines

GET_INPUT:
    LDA #0
    STA KEYBOARD
WAIT_KEY:
    LDA KEYBOARD
    CMP #0
    BEQ WAIT_KEY
    
    RTS

MOVE_PLAYER:
    LDA KEYBOARD
    CMP #LEFT
    BEQ MOVE_LEFT
    CMP #RIGHT
    BEQ MOVE_RIGHT
    CMP #UP
    BEQ MOVE_UP
    CMP #DOWN
    BEQ MOVE_DOWN

    RTS

MOVE_LEFT:
    DEC playerX
    RTS

MOVE_RIGHT:
    INC playerX
    RTS

MOVE_UP:
    DEC playerY
    RTS

MOVE_DOWN:
    INC playerY
    RTS

ENTER_PLANET:
    ; Add code to handle entering a planet here
    RTS

PRINT:
    JSR $FDDA
    RTS

PRINTN:
    JSR $FD9D
    RTS

PRINT_NUMBER:
    ; Add code to print number here (use accumulator)
    RTS

; Keyboard Constants
LEFT = $FF
RIGHT = $FE
UP = $FD
DOWN = $FC

; Memory Layout
KEYBOARD = $7F

.END
