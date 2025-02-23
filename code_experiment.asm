
.ORG $0200

; Constants
CR = $0D
LF = $0A
PRINT = $FFD2

; Variables
playlist .byte "Song 1",CR,LF,"Song 2",CR,LF,"Song 3",CR,LF,"Song 4",CR,LF,0
current_song .byte 0

start:
    lda #<playlist
    ldx #>playlist
    ldy #8
    jsr PRINT

main_loop:
    lda current_song
    beq end

    lda #<playlist
    ldx #>playlist
    clc
    adc current_song
    tay
    ldx #0

next_line:
    lda (playlist),y
    beq end
    jsr PRINT
    iny
    inx
    bne next_line

end:
    brk

; Subroutine to print a null-terminated string
PRINT_STRING:
    lda (0),y
    beq PRINT_STRING_DONE
    jsr PRINT
    iny
    jmp PRINT_STRING
PRINT_STRING_DONE:
    rts
