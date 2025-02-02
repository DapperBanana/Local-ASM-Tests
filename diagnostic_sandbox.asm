
    .org $0200
    .word start

start:
    LDX #$00
    LDY #$00
    
mainLoop:
    JSR printMenu
    JSR getUserSelection
    CPY #$01
    BEQ buyStock
    CPY #$02
    BEQ sellStock
    CPY #$03
    BEQ displayPortfolio
    CPY #$04
    BEQ exitProgram
    
    JMP mainLoop

printMenu:
    LDA #$0C
    JSR $FFD2 ; Print new line
    LDA #"1"
    JSR $FFD2 ; Print '1.'
    LDA #" Buy Stock\n"
    JSR $FFD2 ; Print 'Buy Stock'
    LDA #"2"
    JSR $FFD2 ; Print '2.'
    LDA #" Sell Stock\n"
    JSR $FFD2 ; Print 'Sell Stock'
    LDA #"3"
    JSR $FFD2 ; Print '3.'
    LDA #" Display Portfolio\n"
    JSR $FFD2 ; Print 'Display Portfolio'
    LDA #"4"
    JSR $FFD2 ; Print '4.'
    LDA #" Exit\n"
    JSR $FFD2 ; Print 'Exit'
    
    RTS

getUserSelection:
    LDA #"Enter your selection: "
    JSR $FFD2 ; Print the prompt
    LDA #$00
    JSR $FFD2 ; Read user input
    STA $200
    LDA $200
    CLC
    ADC #$D0 ; Convert ASCII to decimal
    TAX
    RTS

buyStock:
    LDA #$0C
    JSR $FFD2 ; Print new line
    LDA #"Buying stock functionality coming soon!"
    JSR $FFD2
    RTS

sellStock:
    LDA #$0C
    JSR $FFD2 ; Print new line
    LDA #"Selling stock functionality coming soon!"
    JSR $FFD2
    RTS

displayPortfolio:
    LDA #$0C
    JSR $FFD2 ; Print new line
    LDA #"Displaying portfolio functionality coming soon!"
    JSR $FFD2
    RTS

exitProgram:
    LDA #$0C
    JSR $FFD2 ; Print new line
    LDA #"Exiting program..."
    JSR $FFD2
    JMP $FFFC ; End program

    .org $FFD2
    .word $FFD2
