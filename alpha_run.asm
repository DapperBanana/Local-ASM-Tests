
    .org $0200       ; Start address of program
    
    LDA #$00         ; Initialize player position (x-coordinate)
    STA player_x
    
    LDA #$00         ; Initialize player position (y-coordinate)
    STA player_y
    
start:
    LDA player_x     ; Display current player position
    JSR PrintHex
    LDA player_y
    JSR PrintHex
    
    JSR GetInput     ; Get user input for movement
    CMP #65          ; Check if input is 'A'
    BEQ move_left    ; Move left if 'A' key is pressed
    CMP #68          ; Check if input is 'D'
    BEQ move_right   ; Move right if 'D' key is pressed
    CMP #87          ; Check if input is 'W'
    BEQ move_up      ; Move up if 'W' key is pressed
    CMP #83          ; Check if input is 'S'
    BEQ move_down    ; Move down if 'S' key is pressed
    JMP start        ; Loop back to start
    
move_left:
    DEC player_x     ; Decrement x-coordinate for left movement
    JMP start
    
move_right:
    INC player_x     ; Increment x-coordinate for right movement
    JMP start
    
move_up:
    DEC player_y     ; Decrement y-coordinate for up movement
    JMP start
    
move_down:
    INC player_y     ; Increment y-coordinate for down movement
    JMP start
    
GetInput:
    LDA #$00         ; Clear A register
    JSR $FFE4       ; Get input from keyboard
    RTS
    
PrintHex:
    PHA              ; Push A register to stack
    LSR              ; Shift right to isolate high nibble
    LSR
    LSR
    LSR
    JSR ConvertToAscii ; Convert high nibble to ASCII
    PLA              ; Pull A register from stack
    AND #$0F         ; Clear high nibble
    JSR ConvertToAscii ; Convert low nibble to ASCII
    RTS
    
ConvertToAscii:
    CMP #$0A         ; Check if digit is 10 or larger
    BCC digit       ; If not, jump to digit conversion
    ADC #$07         ; Add 7 to convert to ASCII
    RTS             ; Return
    
digit:
    ORA #$30         ; Convert digit to ASCII
    RTS              ; Return
