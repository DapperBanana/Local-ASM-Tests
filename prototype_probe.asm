
    .begin

    LDX #0      ; X register for player choice
    LDY #0      ; Y register for computer choice

  again:
    LDA #$00    ; Prompt for user input
    JSR $FFD2   ; Print the prompt
    LDA #$01
    JSR $FFD2   ; Print 'Rock (1)'

    LDA #$00    ; Prompt for user input
    JSR $FFD2   ; Print the prompt
    LDA #$02
    JSR $FFD2   ; Print 'Paper (2)'

    LDA #$00    ; Prompt for user input
    JSR $FFD2   ; Print the prompt
    LDA #$03
    JSR $FFD2   ; Print 'Scissors (3)'

    LDA #$00    ; Prompt for user input
    JSR $FFD2   ; Print the prompt
    LDA #$04
    JSR $FFD2   ; Print 'Enter your choice (1-3): '

    LDA #$00    ; Get user input
    JSR $FFD2   ; Print the prompt
    LDA #$02
    JSR $FFCB   ; Get user input

    CMP #$31    ; Check if user input is valid
    BCC again   ; Loop again if invalid
    CMP #$34
    BCS again

    TAX         ; Store user choice in X register

    LDA #$FF    ; Get random number for computer choice
    JSR $FFEB   ; Get random number
    AND #$03
    INY         ; Store random number in Y register

    ; Compare user choice with computer choice
    CMP #1
    BEQ rock
    CMP #2
    BEQ paper
    CMP #3
    BEQ scissors

rock:
    CPY #3      ; Computer chose scissors
    BNE you_win
    JMP draw

paper:
    CPY #1      ; Computer chose rock
    BNE you_win
    JMP draw

scissors:
    CPY #2      ; Computer chose paper
    BNE you_win
    JMP draw

you_win:
    LDA #$00
    JSR $FFD2   ; Print 'You win!'

draw:
    LDA #$00
    JSR $FFD2   ; Print 'It's a draw!'

    JMP again   ; Play again

    .end
