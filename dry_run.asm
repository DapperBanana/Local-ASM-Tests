
        .org $0200

start   lda #1
        sta $c000   ; Set cursor to row 1, col 1
        lda #'J'
        jsr CHROUT
        lda #'A'
        jsr CHROUT
        lda #'N'
        jsr CHROUT
        lda #'U'
        jsr CHROUT
        lda #'A'
        jsr CHROUT
        lda #'R'
        jsr CHROUT
        lda #'Y'
        jsr CHROUT
        lda #32
        jsr CHROUT   ; Space
        lda #'2'
        jsr CHROUT
        lda #'0'
        jsr CHROUT
        lda #'2'
        jsr CHROUT
        lda #'2'
        jsr CHROUT
        lda #'2'
        jsr CHROUT
        lda #13
        jsr CHROUT   ; Carriage return

        lda #'M'
        jsr CHROUT
        lda #'o'
        jsr CHROUT
        lda #'n'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'T'
        jsr CHROUT
        lda #'u'
        jsr CHROUT
        lda #'e'
        jsr CHROUT
        lda #32
        jsr CHROUT   ; Space
        lda #'W'
        jsr CHROUT
        lda #'e'
        jsr CHROUT
        lda #'d'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'T'
        jsr CHROUT
        lda #'h'
        jsr CHROUT
        lda #'u'
        jsr CHROUT
        lda #'r'
        jsr CHROUT
        lda #32
        jsr CHROUT   ; Space
        lda #'F'
        jsr CHROUT
        lda #'r'
        jsr CHROUT
        lda #'i'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'S'
        jsr CHROUT
        lda #'a'
        jsr CHROUT
        lda #'t'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'S'
        jsr CHROUT
        lda #'u'
        jsr CHROUT
        lda #'n'
        jsr CHROUT
        lda #13
        jsr CHROUT   ; Carriage return

        lda #'M'
        jsr CHROUT
        lda #'o'
        jsr CHROUT
        lda #'n'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'W'
        jsr CHROUT
        lda #'e'
        jsr CHROUT
        lda #'d'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'T'
        jsr CHROUT
        lda #'u'
        jsr CHROUT
        lda #'e'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'T'
        jsr CHROUT
        lda #'h'
        jsr CHROUT
        lda #'u'
        jsr CHROUT
        lda #'r'
        jsr CHROUT
        lda #'s'
        jsr CHROUT
        lda #'d'
        jsr CHROUT
        lda #'a'
        jsr CHROUT
        lda #'y'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'F'
        jsr CHROUT
        lda #'r'
        jsr CHROUT
        lda #'i'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'S'
        jsr CHROUT
        lda #'a'
        jsr CHROUT
        lda #'t'
        jsr CHROUT
        lda #' '
        jsr CHROUT
        lda #'S'
        jsr CHROUT
        lda #'u'
        jsr CHROUT
        lda #'n'
        jsr CHROUT
        lda #'d'
        jsr CHROUT
        lda #'a'
        jsr CHROUT
        lda #'y'
        jsr CHROUT
        lda #13
        jsr CHROUT   ; Carriage return

end     jmp end

CHROUT  lda $c000   ; Read cursor position
        sta $f000   ; Output character to screen
        inc $c000   ; Increment cursor position
        rts
