
; Fitness Tracking System

.memory
    .org $0600

.text
start:
    lda #0         ; Initialize variables
    sta calories
    sta steps

loop:
    jsr clearScreen     ; Clear screen
    jsr displayMenu     ; Display menu
    jsr readOption      ; Read user input

    lda option          ; Check user option
    cmp #1
    beq addCalories
    cmp #2
    beq addSteps
    cmp #3
    beq displayStats
    cmp #4
    beq exit

    jmp loop            ; Invalid option, loop again

addCalories:
    jsr clearScreen
    jsr promptInput
    jsr readInput
    clc
    adc calories
    sta calories
    jmp loop

addSteps:
    jsr clearScreen
    jsr promptInput
    jsr readInput
    clc
    adc steps
    sta steps
    jmp loop

displayStats:
    jsr clearScreen
    jsr displayCalories
    jsr displaySteps
    jsr waitForInput
    jmp loop

exit:
    rts

clearScreen:
    lda #$0C
    jsr $FFD2
    rts

displayMenu:
    lda #$00
    ldx #menuText
    jsr printString
    rts

readOption:
    lda #0
    jsr $FFCF
    sta option
    rts

promptInput:
    lda #1
    ldx #inputText
    jsr printString
    rts

readInput:
    lda #0
    jsr $FFCF
    sta input
    rts

displayCalories:
    ldx #caloriesText
    jsr printString
    lda calories
    jsr printNumber
    rts

displaySteps:
    ldx #stepsText
    jsr printString
    lda steps
    jsr printNumber
    rts

printString:
    lda #$00
printLoop:
    lda (x),y
    beq printDone
    jsr $FFD2
    inx
    inx
    jmp printLoop
printDone:
    rts

printNumber:
    jsr $FFD2
    lda #$20
    jsr $FFD2
    rts

waitForInput:
    lda #0
    jsr $FFCF
    rts

.data
option: .byte 0
calories: .byte 0
steps: .byte 0
input: .byte 0

menuText:
    .text "Fitness Tracking System", $0D, $0A
    .text "1. Add calories", $0D, $0A
    .text "2. Add steps", $0D, $0A
    .text "3. Display stats", $0D, $0A
    .text "4. Exit", $0D, $0A
    .byte 0

inputText:
    .text "Enter value: ", $00
    .byte 0

caloriesText:
    .text "Calories: ", $20
    .byte 0

stepsText:
    .text "Steps: ", $20
    .byte 0

.end
