
    .org $0200  ; Start program at memory location $0200
    
    ; Constants
    .equ MAX_STEPS = 1000
    .equ MAX_CALORIES = 5000
    .equ MAX_DISTANCE = 10
    
    ; Variables
    .org $0300
steps = $00
calories = $01
distance = $02
    
    ; Program starts execution here
    .org $0400
start:
    lda #$00  ; Initialize steps to zero
    sta steps
    lda #$00  ; Initialize calories to zero
    sta calories
    lda #$00  ; Initialize distance to zero
    sta distance
    
    ; Main loop
mainLoop:
    ; Display menu
    lda #"1"  ; Display menu option 1: Log steps
    jsr putChar
    lda #"2"  ; Display menu option 2: Log calories
    jsr putChar
    lda #"3"  ; Display menu option 3: Log distance
    jsr putChar
    lda #$0d  ; Display newline character
    jsr putChar
    
    ; Get user input
    jsr getUserInput
    
    ; Process user input
    cmp #"1"
    beq logSteps
    cmp #"2"
    beq logCalories
    cmp #"3"
    beq logDistance
    
    ; Invalid input, loop back to menu
    jmp mainLoop
    
logSteps:
    ; Log steps
    jsr getUserInput
    sta steps
    jmp mainLoop
    
logCalories:
    ; Log calories
    jsr getUserInput
    sta calories
    jmp mainLoop
    
logDistance:
    ; Log distance
    jsr getUserInput
    sta distance
    jmp mainLoop
    
    ; Get user input
getUserInput:
    ldx #$00
getUserInputLoop:
    lda $C000,x  ; Read user input from input buffer
    cmp #$0d  ; Check if user pressed Enter
    beq endGetUserInput
    jsr putChar  ; Echo the input character
    inx
    jmp getUserInputLoop
endGetUserInput:
    rts
    
    ; Output routine to display characters
putChar:
    sta $D020  ; Write character to screen
    rts
    
    .end
