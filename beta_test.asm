
START:
    LDX #0   ; initialize X register as spaceship position
    LDY #$2C ; load spaceship symbol '*'
    STY $0200,X   ; draw spaceship on the screen
    
LOOP:
    LDA $FF00   ; read input from keyboard buffer
    CMP #$41    ; check if input is 'A' (move left)
    BEQ MOVE_LEFT
    CMP #$44    ; check if input is 'D' (move right)
    BEQ MOVE_RIGHT

JUMP:
    JMP LOOP   ; repeat loop

MOVE_LEFT:
    DEX        ; decrement X register to move left
    BPL UPDATE ; check if spaceship is not at edge of screen
    INX        ; do not go beyond left edge of screen
    JMP LOOP

MOVE_RIGHT:
    INX        ; increment X register to move right
    CPX #$20   ; check if spaceship is not at edge of screen
    BCC UPDATE ; spaceship is within bounds
    DEX        ; do not go beyond right edge of screen
    JMP LOOP

UPDATE:
    STY $0200,X   ; update spaceship position on the screen
    JMP LOOP

.END START
