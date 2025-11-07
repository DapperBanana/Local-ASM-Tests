
.START
    LDA STARTPOS    ; load starting position
    STA CURRPOS
    JSR PRINTMAZE   ; print maze
    JSR SOLVEMAZE   ; solve maze
    JSR PRINTMAZE   ; print solved maze
    BRK

PRINTMAZE
    LDX #0          ; initialize X register
PRINTLOOP
    LDY #0          ; initialize Y register
PRINTLINE
    LDA MAZE,X     ; load current cell
    JSR PRINTCHAR   ; print the character
    INY             ; increment Y register
    CPY #8          ; check if end of line
    BNE PRINTLINE   ; if not, continue printing
    INX             ; increment X register
    CPX #8          ; check if end of maze
    BNE PRINTLOOP   ; if not, continue printing
    RTS

PRINTCHAR
    CMP #0          ; check if wall
    BEQ PRINTWALL   ; if wall, print #
    CMP #2          ; check if finish
    BEQ PRINTFINISH ; if finish, print !
    JSR PRINTSPACE  ; print space
    RTS

PRINTSPACE
    LDA #' '        ; load space character
    JSR $FFD2      ; KERNAL routine to print character
    RTS

PRINTWALL
    LDA #'#'        ; load wall character
    JSR $FFD2      ; KERNAL routine to print character
    RTS

PRINTFINISH
    LDA #'!'        ; load finish character
    JSR $FFD2      ; KERNAL routine to print character
    RTS

SOLVEMAZE
    LDA CURRPOS    ; load current position
    STA TEMPPOS
    LDA MAZE,X     ; load current cell
    CMP #2          ; check if finish
    BEQ MAZESOLVED  ; if finish, exit
    CMP #1          ; check if wall or visited
    BEQ BACKTRACK   ; if wall or visited, backtrack
    STA MAZE,X     ; mark current cell as visited
    DEX             ; move left
    JSR SOLVEMAZE   ; recursively try left
    INX             ; move back
    DEX             ; move right
    JSR SOLVEMAZE   ; recursively try right
    INX             ; move back
    DEY             ; move up
    JSR SOLVEMAZE   ; recursively try up
    INY             ; move back
    DEY             ; move down
    JSR SOLVEMAZE   ; recursively try down
    INY             ; move back
    BRA MAZESOLVED  ; exit

BACKTRACK
    LDA TEMPPOS    ; load previous position
    STA CURRPOS
    RTS

MAZESOLVED
    RTS

STARTPOS
    .byte 4        ; starting position
CURRPOS
    .byte 4        ; current position
TEMPPOS
    .byte 0        ; temporary position

MAZE
    .byte 0,0,1,0,0,0,0,0 ; maze data
    .byte 0,1,0,1,1,1,1,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,1,1,1,1,1,1,0
    .byte 0,0,0,0,0,0,1,2
    .byte 0,0,0,0,0,0,0,0
    .byte 0,1,1,1,1,1,1,0
    .byte 0,0,0,0,0,0,0,0

    .org $fffc
    .word .START
