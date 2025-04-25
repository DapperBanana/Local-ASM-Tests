
; Generate a random crossword puzzle
;
; Description: This program generates a random 5x5 crossword puzzle
; with random letters as placeholders. The puzzle will have
; black squares to separate the words.

        .org $0200     ; Start address of program
        sei            ; Disable interrupts
        ldx #$00       ; Initialize X to 0
        
loop:
        lda #$41       ; Load letter 'A' into accumulator
        sta $0400, x   ; Store the letter at memory location $0400 + X
        
        inx            ; Increment X
        cpx #$1F       ; Check if X is at the end of memory block ($0400 + 31)
        bne loop       ; If not, continue looping
        
        jmp $FFFC      ; End program

        .org $FFFC     ; Reset vector address
        .word start    ; Define start address of program
