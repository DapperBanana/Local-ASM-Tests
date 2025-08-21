
        processor 6502
        include "vcs.h"

        ; define constants
        .equ BUF_SIZE, 20
        .equ NULL, 0
        .equ SPACE, $20
        .equ CAPITALIZE, $DF

        ; define variables
        .var inputBuffer BUF_SIZE, 0
        .var outputBuffer BUF_SIZE, 0
        .var index, 0
        .var currChar, 0
        .var convertFlag, 0

start:
        ; initialize variables
        ldx #BUF_SIZE
        lda #NULL
initBuffer:
        sta inputBuffer, x
        sta outputBuffer, x
        dex
        bpl initBuffer

        ; read input string
        lda #"Hello, World!"
        sta inputBuffer
        ldx #0
readLoop:
        lda inputBuffer, x
        beq endOfString
        jsr convertToTitleCase
        jmp readLoop
endOfString:
        ; print result
        ldx #0
printLoop:
        lda outputBuffer, x
        beq endPrint
        jsr CHROUT
        inx
        jmp printLoop
endPrint:
        rts

convertToTitleCase:
        lda inputBuffer, x
        cmp #"a"
        bcc notLowerCase
        cmp #"z"
        bcs notLowerCase
        jsr convertToUpperCase
notLowerCase:
        sta outputBuffer, x
        rts

convertToUpperCase:
        sec
        lda CAPITALIZE
        sbc #"a"
        sta convertFlag
        lda inputBuffer, x
        sec
        sbc #"a"
        cmp #"z" - "a"
        bcc skipConversion
        lda inputBuffer, x
        lda convertFlag
        sec
        sbc #"a" - "A"
        sta outputBuffer, x
        rts

skipConversion:
        sta outputBuffer, x
        rts
