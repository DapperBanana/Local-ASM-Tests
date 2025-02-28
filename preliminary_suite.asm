
    .org $0200

start:
    LDX #$00       ; initialize index register X to 0
    LDY #$00       ; initialize index register Y to 0
    JSR clearScreen ; clear the screen
    
    ; Display menu
    LDA #menuText  ; load address of menuText string
    JSR printString ; print menuText
    
    LDA #'>'
    JSR printChar
    LDA #'>'
    JSR printChar

inputLoop:
    JSR getInput   ; get user input
    CMP #'1'       ; compare input to '1'
    BEQ exercise1  ; jump to exercise1 if input is '1'
    CMP #'2'       ; compare input to '2'
    BEQ exercise2  ; jump to exercise2 if input is '2'
    CMP #'3'       ; compare input to '3'
    BEQ exercise3  ; jump to exercise3 if input is '3'
    
    ; handle invalid input
    LDA #invalidInputText
    JSR printString
    JMP inputLoop ; jump back to inputLoop
    
exercise1:
    LDA #exercise1Text
    JSR printString
    JMP start

exercise2:
    LDA #exercise2Text
    JSR printString
    JMP start

exercise3:
    LDA #exercise3Text
    JSR printString
    JMP start
    
clearScreen:
    LDA #$93
    STA $D020
    LDA #$ff
    STA $D021
    RTS
    
printChar:
    STA $d020
    RTS
    
printString:
    LDY #$00
printCharLoop:
    LDA (LDA),Y
    BEQ printDone
    JSR printChar
    INY
    JMP printCharLoop
printDone:
    RTS
    
getInput:
    LDA #$FF
inputLoop:
    LDA $D011
    AND #$10
    BEQ inputLoop
    LDA $D010
    RTS
    
.menuText:         !text "1. Run 5km",13,10,"2. Lift weights",13,10,"3. Yoga session",13,10,"Choose an exercise: "
.exercise1Text:    !text "You ran 5km! Good job!",13,10
.exercise1Text:    !text "You lifted weights! Keep it up!",13,10
.exercise3Text:    !text "You had a relaxing yoga session",13,10
.invalidInputText: !text "Invalid input. Please try again",13,10
