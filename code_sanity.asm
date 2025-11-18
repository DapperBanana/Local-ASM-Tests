
; 6502 Assembly code to generate a random walk plot using Matplotlib

START:
    CLD
    LDA #0     ; Initialize x coordinate
    STA X_POS
    LDA #0     ; Initialize y coordinate
    STA Y_POS
    LDX #100   ; Set number of steps
    
LOOP:
    JSR RANDOMIZE   ; Generate random direction
    JSR MOVE        ; Move to the new coordinate
    JSR PLOT        ; Plot the new point on the graph
    
    DEX
    BNE LOOP        ; Continue looping until all steps are completed
    
DONE:
    RTS

RANDOMIZE:
    LDA #$FF
    AND RANDOM_MASK
    STA DIRECTION
    RTS

MOVE:
    LDA DIRECTION
    AND #1
    BEQ CHECK_X        ; If direction is 0, move along x-axis
    LDA X_POS
    CLC
    ADC #1
    STA X_POS
    JMP DONE_MOVE
    
CHECK_X:
    LDA DIRECTION
    AND #2
    BEQ UP
    LDA X_POS
    SEC
    SBC #1
    STA X_POS
    JMP DONE_MOVE
    
UP:
    LDA DIRECTION
    AND #4
    BEQ LEFT
    LDA Y_POS
    SEC
    SBC #1
    STA Y_POS
    JMP DONE_MOVE
    
LEFT:
    LDA DIRECTION
    AND #8
    BEQ RIGHT
    LDA X_POS
    CLC
    ADC #1
    STA X_POS
    JMP DONE_MOVE
    
RIGHT:
    LDA DIRECTION
    AND #16
    BEQ DONE_MOVE
    LDA X_POS
    SEC
    SBC #1
    STA X_POS
    
DONE_MOVE:
    RTS

PLOT:
    LDA Y_POS
    STA Y_REGISTER
    LDA X_POS
    STA X_REGISTER
    
    ; Call Matplotlib library to plot the point
    
    RTS

RANDOM_MASK: .BYTE %00011111
DIRECTION:   .BYTE 0
X_POS:       .BYTE 0
Y_POS:       .BYTE 0
X_REGISTER:  .BYTE 0
Y_REGISTER:  .BYTE 0
