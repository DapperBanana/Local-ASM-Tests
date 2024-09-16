
; Check if a given matrix is symmetric

.org $0200

start:
    LDX #0          ; Initialize row index
loop:
    LDY #0          ; Initialize column index
inner_loop:
    LDA matrix,X    ; Load element from matrix at (X,Y)
    CMP matrix,Y    ; Compare with element at (Y,X)
    BNE not_symmetric  ; Branch if not equal
    INY             ; Increment column index
    CPY #4          ; Check if reached end of row
    BNE inner_loop  ; Branch to inner_loop if not
    INX             ; Increment row index
    CPX #4          ; Check if reached end of matrix
    BNE loop        ; Branch to loop if not

symmetric:
    LDA #$01        ; Set flag to 1 to indicate matrix is symmetric
    JMP end         ; Jump to end

not_symmetric:
    LDA #$00        ; Set flag to 0 to indicate matrix is not symmetric

end:
    STX result      ; Store the result in memory
    BRK             ; End program

result:
    .byte 0         ; Result variable

matrix:
    .byte 1, 2, 3, 4
    .byte 2, 5, 6, 7
    .byte 3, 6, 8, 9
    .byte 4, 7, 9, 10

.end
