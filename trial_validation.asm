
LOOP:
    LDA #0  ; Clear accumulator
    JSR $FFD2  ; Print prompt for user input

    JSR $FFCF  ; Get user input
    CMP #80  ; Compare user input to 'P'
    BEQ PRINT_PROGRESS

    CMP #67  ; Compare user input to 'C'
    BEQ PRINT_CALORIES

    CMP #68  ; Compare user input to 'D'
    BEQ PRINT_DISTANCE

    CMP #81  ; Compare user input to 'Q'
    BEQ QUIT

    JMP LOOP  ; Continue looping

PRINT_PROGRESS:
    LDA #"You have completed 50% of your fitness goal."  ; Print progress message
    JSR $FFD2
    JMP LOOP

PRINT_CALORIES:
    LDA #"You have burned 500 calories today."  ; Print calorie message
    JSR $FFD2
    JMP LOOP

PRINT_DISTANCE:
    LDA #"You have run 5 miles today."  ; Print distance message
    JSR $FFD2
    JMP LOOP

QUIT:
    RTS  ; Exit program

    .ORG $FFD2
    .BYTE $FF

    .ORG $FFCF
    .BYTE $FF
