
START:
    LDX #10      ; Set player health to 10
    LDY #10      ; Set enemy health to 10

BATTLE_LOOP:
    ; Show battle status
    LDA #10
    JSR PRINT_NUMBER   ; Print player health
    LDA #32
    JSR PRINT_CHAR     ; Print space
    LDA #10
    JSR PRINT_NUMBER   ; Print enemy health
    LDA #13
    JSR PRINT_CHAR     ; Print newline

    ; Player turn
    LDA #65         ; A = ASCII code for 'A' (attack)
    JSR PRINT_CHAR  ; Print A for attack
    JSR READ_CHAR   ; Wait for user input

    CMP #65         ; Check if input is 'A'
    BEQ PLAYER_ATTACK ; Branch to player attack if input is 'A'

    ; Enemy turn
    LDA #69         ; E = ASCII code for 'E' (enemy attack)
    JSR PRINT_CHAR  ; Print E for enemy attack
    JSR WAIT_FOREVER ; Wait indefinitely

PLAYER_ATTACK:
    LDA #2          ; Player attack power
    CLC
    ADC Y           ; Subtract player attack power from enemy health
    STA Y

    BEQ PLAYER_WINS   ; Branch to player wins if enemy health is zero or less

    ; Enemy attack
    LDA #3           ; Enemy attack power
    CLC
    ADC X            ; Subtract enemy attack power from player health
    STA X

    BNE BATTLE_LOOP   ; Branch back to battle loop if player health is not zero

PLAYER_WINS:
    LDA #87         ; W = ASCII code for 'W' (player wins)
    JSR PRINT_CHAR  ; Print W for player wins
    JMP END

END:
    BRK             ; End of program

PRINT_CHAR:
    STA $0200
    LDA #14
    STA $FFD2
    RTS

PRINT_NUMBER:
    STA $0200
    LDX #00
    STX $0201
    LDA #15
    STA $FFD2
LOOP:
    SEC
    LDA #10
    DIV $0200
    STA $0200
    CLC
    ADC #48
    STA $020A,X
    LDA $0201
    CMP #00
    BEQ DONE
    INX
    JMP LOOP
DONE:
    STA $FFD2
    RTS

READ_CHAR:
    LDA $00EE
    CMP #00
    BEQ READ_CHAR
    RTS

WAIT_FOREVER:
    JMP WAIT_FOREVER
