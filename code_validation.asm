
; Check if a given matrix is a magic square

; Initialize variables
Matrix .block $200 ; Matrix of size 3x3
MagicSum .word 15 ; Sum of each row/column/diagonal in a magic square

; Main program
start lda #$00 ; Initialize index
       sta Index
loop lda Matrix, x ; Load element at index x
       sta Temp ; Store element in Temp
       clc
       adc MagicSum, x ; Add MagicSum of the row/column/diagonal
       cmp #$15 ; Compare with 15 (magic sum)
       bne notMagicSquare ; If not equal, exit loop
       inx ; Increment index
       cpx #$09 ; Check if end of matrix reached
       bne loop ; If not, continue loop
       jmp magicSquare ; If yes, jump to magicSquare
notMagicSquare lda #$00 ; Load 0 to accumulator
               rts ; Return

magicSquare lda #$01 ; Load 1 to accumulator
            rts ; Return

Index .byte $00 ; Index variable
Temp .byte $00 ; Temporary variable
