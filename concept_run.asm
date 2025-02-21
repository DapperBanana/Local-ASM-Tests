
; Tic-Tac-Toe Game in 6502 Assembly

        .org    $0200

        lda     #$91            ; Set random start position
        sta     $90
        lda     #$50
        sta     $91
        lda     #$1E            ; Set cursor position
        sta     $92

restart clc
        lda     #$00            ; Clear screen
        ldx     #$10
        ldy     #$00
clear   sta     $0400, y
        iny
        bne     clear
        dex
        bne     clear

        lda     #'X'            ; Print initial board
        jsr     printChar
        lda     #'|'
        jsr     printChar
        lda     #'X'
        jsr     printChar
        lda     #$92            ; Move cursor to start position
        sta     $92
        lda     #13
        sta     $9D
        jsr     printChar

main    lda     $1F
        cmp     #$8D            ; Check for Enter key press
        beq     enterPressed

        lda     $1F
        cmp     #$FE            ; Check for arrow key press
        beq     arrowPressed

        lda     #0
        sta     $1E
        lda     $02
        and     #$7F            ; Store ASCII value of character
        sta     $1F
        
printChar
        lda     $1E
        cmp     #$7F            ; Check for backspace key press
        beq     backspace
        jsr     cursorRight
        sta     $0400, x         ; Print character to screen
        jmp     main

backspace
        jsr     cursorLeft
        lda     #' '
        sta     $0400, x         ; Print space to screen
        jmp     main

cursorRight
        inc     $92             ; Move cursor right
        lda     $92
        cmp     #20
        bne     skip
        inc     $91
skip    rts

cursorLeft
        lda     $92             ; Move cursor left
        cmp     #$90
        beq     skip1
        dec     $92
skip1   rts

arrowPressed
        lda     $1E
        cmp     #$50            ; Check for down arrow key press
        bne     skip2
        jsr     cursorDown
        jmp     main

skip2   lda     $1E
        cmp     #$48            ; Check for up arrow key press
        bne     main
        jsr     cursorUp
        jmp     main

cursorDown
        inc     $9D             ; Move cursor down
        rts

cursorUp
        dec     $9D             ; Move cursor up
        rts

enterPressed
        lda     $92
        cmp     #$91
        beq     moveX
        lda     $92
        cmp     #$92
        beq     moveO
        lda     $92
        cmp     #$93
        beq     moveX
        lda     $92
        cmp     #$95
        beq     moveO
        lda     $92
        cmp     #$96
        beq     moveX
        lda     $92
        cmp     #$97
        beq     moveO
        lda     $92
        cmp     #$98
        beq     moveX
        lda     $92
        cmp     #$99
        beq     moveO
        lda     $92
        cmp     #$9A
        beq     moveX
        lda     $92
        cmp     #$9B
        beq     moveO
        lda     $92
        cmp     #$9D
        beq     moveX
        lda     $92
        cmp     #$9E
        beq     moveO

        jmp     main

moveX   lda     #'X'
        jsr     printChar
        jmp     main

moveO   lda     #'O'
        jsr     printChar
        jmp     main

        .end
