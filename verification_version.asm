
    .text
    .org $0200

    ; Initialize program
    LDX #$00  ; Counter for movie recommendations
    STX counter

start:
    ; Print menu
    LDA #<menu
    LDY #>menu
    JSR printString

    ; Get user input
    JSR getUserInput

    ; Process user input
    CMP #'1'
    BEQ comedy
    CMP #'2'
    BEQ action
    CMP #'3'
    BEQ drama
    CMP #'4'
    BEQ sciFi
    CMP #'5'
    BEQ finish

    ; Invalid input
    LDA #<invalidInput
    LDY #>invalidInput
    JSR printString
    JMP start

comedy:
    ; Display comedy movie recommendation
    LDA #<comedyMovie
    LDY #>comedyMovie
    JSR printString
    INX
    JMP start

action:
    ; Display action movie recommendation
    LDA #<actionMovie
    LDY #>actionMovie
    JSR printString
    INX
    JMP start

drama:
    ; Display drama movie recommendation
    LDA #<dramaMovie
    LDY #>dramaMovie
    JSR printString
    INX
    JMP start

sciFi:
    ; Display sci-fi movie recommendation
    LDA #<sciFiMovie
    LDY #>sciFiMovie
    JSR printString
    INX
    JMP start

finish:
    ; Display final recommendations based on user input
    LDA #<finalRecommendation
    LDY #>finalRecommendation
    JSR printString

    ; Terminate program
    BRK

printString:
    TXA
    PHA
printLoop:
    LDA (Y), X
    BEQ donePrint
    JSR $FFD2
    INX
    JMP printLoop
donePrint:
    PLA
    TAX
    RTS

getUserInput:
    LDA #$00
    JSR $FFCF
    RTS

    .data
menu:   .text "Choose a movie genre: 1. Comedy 2. Action 3. Drama 4. Sci-fi 5. Finish", $00
invalidInput: .text "Invalid input. Please try again.", $00
comedyMovie: .text "You should watch 'The Hangover'", $00
actionMovie: .text "You should watch 'Mission: Impossible'", $00
dramaMovie: .text "You should watch 'The Shawshank Redemption'", $00
sciFiMovie: .text "You should watch 'Blade Runner'", $00
finalRecommendation: .text "Thank you for using our movie recommendation system!", $00

    .end
