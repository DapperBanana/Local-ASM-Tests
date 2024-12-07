
        .org $6000

START   LDA #0          ; Initialize variables
        STA score
        STA level
        LDX #0
        LDY #0

MAIN    JSR PRINT       ; Display game info
        JSR INKEY       ; Wait for player input
        CMP #"w"        ; Check player input
        BEQ MOVE_UP
        CMP #"s"
        BEQ MOVE_DOWN
        CMP #"a"
        BEQ MOVE_LEFT
        CMP #"d"
        BEQ MOVE_RIGHT
        JMP MAIN

MOVE_UP INY             ; Move spaceship up
        JMP MAIN

MOVE_DOWN DEY           ; Move spaceship down
        JMP MAIN

MOVE_LEFT DEX           ; Move spaceship left
        JMP MAIN

MOVE_RIGHT INX          ; Move spaceship right
        JMP MAIN

PRINT   LDA score       ; Display score
        JSR OUTDEC
        LDA #" "
        JSR OUTCHR
        LDA #"S"
        JSR OUTCHR
        LDA #" "
        JSR OUTCHR
        LDA level       ; Display level
        JSR OUTDEC
        LDA #" "
        JSR OUTCHR
        LDA #"L"
        JSR OUTCHR
        LDA #13         ; New line
        JSR OUTCHR
        RTS

INKEY   LDA #0
        STA $C000       ; Clear keyboard input
WAIT    LDA $C000
        BEQ WAIT
        RTS

OUTCHR  STA $D013       ; Output character
        RTS

OUTDEC  PHA
        LDX #0
        LSR             ; Divide by 10
        LSR
        LSR
        LSR
        LDA #$30        ; Convert to ASCII
        CLC
        ADC #$30
        STA $D013
LOOP    LDA #0
        STA $D014       ; Delay loop
INCDEC  INC $D014
        BNE INCDEC
        DEX
        BNE LOOP
        PLA
        RTS

score   .BYTE 0
level   .BYTE 0

        .end
