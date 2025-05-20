
; Space Ship Game

.inesprg 1
.ineschr 1

RAMstart = $0200

; Constants
X_MAX = 39
Y_MAX = 23
SHIP_X = 20
SHIP_Y = 10

; Screen memory
SCRN_COLS = 40
SCRN_ADDR = $200 ; Start of screen memory

; Character codes
BLANK = $20 ; Blank space
SHIP = $01 ; Ship character
ASTEROID = $02 ; Asteroid character

; Variables
shipX = SHIP_X
shipY = SHIP_Y
asteroidX = 0
asteroidY = 0
score = 0

init:
    ; Initialize screen
    LDX #0
initLoop:
    LDA #BLANK
    STA SCRN_ADDR, X
    INX
    CPX #SCRN_COLS
    BNE initLoop
    
    ; Place ship on screen
    LDA #SHIP
    STA SCRN_ADDR + SHIP_Y * SCRN_COLS + SHIP_X

gameLoop:
    ; Clear ship position
    LDA #BLANK
    STA SCRN_ADDR + shipY * SCRN_COLS + shipX
    
    ; Move ship
    JSR readInput
    JSR moveShip
    
    ; Spawn asteroid
    JSR spawnAsteroid
    
    ; Move asteroid
    JSR moveAsteroid
    
    ; Check collision
    JSR checkCollision
    
    ; Update screen
    LDA #SHIP
    STA SCRN_ADDR + shipY * SCRN_COLS + shipX
    LDA #ASTEROID
    STA SCRN_ADDR + asteroidY * SCRN_COLS + asteroidX
    
    ; Display score
    LDA score
    STA SCRN_ADDR + 1
    
    ; Check game over
    JSR checkGameOver
    
    ; Loop back to gameLoop
    JMP gameLoop
    
readInput:
    LDX #0
    LDY #0
    JSR $FFCA ; Read keyboard input
    CMP #0 ; No key pressed
    BEQ noInput
    CMP #$E0 ; Up arrow
    BEQ moveUp
    CMP #$13 ; Down arrow
    BEQ moveDown
    CMP #$11 ; Left arrow
    BEQ moveLeft
    CMP #$10 ; Right arrow
    BEQ moveRight
noInput:
    RTS

moveUp:
    DEY
    STA $00
    RTS

moveDown:
    INY
    STA $00
    RTS

moveLeft:
    DEX
    STA $00
    RTS

moveRight:
    INX
    STA $00
    RTS

moveShip:
    LDA $00
    BEQ moveDone
    SEC
    SBC #1
    STA shipX
    BCC moveDone
    CLC
    ADC SCRN_COLS
    STA shipY
moveDone:
    RTS

spawnAsteroid:
    LDA asteroidX
    BEQ spawnDone
    DEC asteroidX
    RTS
spawnDone:
    LDA #X_MAX
    STA asteroidX
    LDA #Y_MAX
    JSR $FFD2 ; Generate random number
    AND #Y_MAX
    CLC
    ADC #1
    STA asteroidY
spawnNewAsteroid:
    RTS

moveAsteroid:
    LDA asteroidY
    BEQ doneMoveAsteroid
    DEC asteroidY
    RTS
doneMoveAsteroid:
    JSR spawnNewAsteroid
    RTS

checkCollision:
    LDA shipX
    CMP asteroidX
    BNE checkY
    LDA shipY
    CMP asteroidY
    BNE checkY
    ; Collision detected
    JSR gameOver
checkY:
    RTS

checkGameOver:
    LDA score
    CMP #5 ; Number of asteroids before game over
    BNE notGameOver
    JSR gameOver
notGameOver:
    RTS

gameOver:
    JMP init

; Implement interrupt routine to refresh screen
IRQ:
    LDA #$00 ; Clear interrupt flag
    RTI

; IRQ handler
IRQHandler:
    LDA #%00001000 ; Enable video mat
    STA $D011 ; Refresh screen
    RTI
