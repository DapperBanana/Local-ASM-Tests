
; Random walk plot generator in 6502 Assembly

* = $0200

start:
    LDX #$00       ; Initialize X as the step counter
    LDY #$00       ; Initialize Y as the random seed

walk_loop:
    CPX #$ff       ; Check if X has reached the maximum number of steps
    BEQ end        ; If X = 255, end the program
    JSR get_random ; Get a random number and store it in accumulator

    AND #$01       ; Mask the random number to get a binary 0 or 1

    CMP #$00       ; Compare the random number with 0
    BEQ step_right ; If random number is 0, take a step to the right
    BNE step_left  ; If random number is 1, take a step to the left

step_right:
    INX            ; Increment X to move right
    JMP plot_step  ; Jump to plot step

step_left:
    DEX            ; Decrement X to move left

plot_step:
    ; Output the current step position in text format
    LDA X
    STA $1000,Y    ; Store X at memory location $1000+i, where i is the current step

    INY            ; Increment Y to move to the next memory location
    JMP walk_loop  ; Continue the random walk loop

get_random:
    ; Pseudo-random number generator
    ; This is a simple implementation and may not be truly random
    LDA $ff        ; Load previous value of accumulator
    ASL            ; Shift left
    ROR            ; Rotate right
    ROR            ; Rotate right
    ROR            ; Rotate right
    ROR            ; Rotate right
    ROR            ; Rotate right
    ROR            ; Rotate right
    TAX            ; Store in X
    RTS

end:
    BRK            ; End the program

* = $1000          ; Start of memory for storing random walk plot

    .org $fffc
    .dw start       ; Set reset vector to start address

    .end
