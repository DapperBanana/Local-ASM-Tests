
; Random Walk Plot using 6502 Assembly

; Set up memory addresses
start:
    LDX #$00            ; Initialize loop counter
    STX $80             ; Initialize X register
    STX $81             ; Initialize Y register

    JSR randomize       ; Call subroutine to initialize random number generator
loop:
    JSR get_random      ; Get a random number
    STA $82             ; Store random number in memory

    LDA $82             ; Load random number back into A register
    AND #$01            ; Mask out lower bit to determine direction
    BEQ direction_x     ; If lower bit is 0, go in x direction
    JMP direction_y     ; If lower bit is 1, go in y direction

direction_x:
    LDA $80             ; Load current x position
    BEQ neg_x           ; If x position is 0, go to neg_x
    INX                 ; Increment x position
    BNE plot            ; Branch to plot
neg_x:
    DEX                 ; Decrement x position
    BNE plot            ; Branch to plot

direction_y:
    LDA $81             ; Load current y position
    BEQ neg_y           ; If y position is 0, go to neg_y
    INY                 ; Increment y position
    BNE plot            ; Branch to plot
neg_y:
    DEY                 ; Decrement y position
    BNE plot            ; Branch to plot

plot:
    TXA                 ; Transfer x position to A register
    STA $80             ; Store back in memory
    TYA                 ; Transfer y position to A register
    STA $81             ; Store back in memory

    JSR plot_point      ; Call subroutine to plot point

    INX                 ; Increment loop counter
    CPX #$64            ; Check if reached end of plot (100 steps)
    BNE loop            ; If not, loop back to get next random number and direction

    BRK                 ; End program

randomize:
    LDA #$02            ; Seeds the random number generator
    STA $D40C
    LDA #<seed_value    ; More seeding
    STA $D40D
    LDA #>seed_value
    STA $D40E
    RTS

get_random:
    LDA $D40F           ; Returns a random number
    RTS

plot_point:
    LDX $80             ; Load x position
    LDA $81             ; Load y position
    JSR draw_point      ; Call subroutine to draw point
    RTS

draw_point:
    ; Implement drawing point using Matplotlib
    RTS

seed_value: .byte $DA, $DC, $AF

