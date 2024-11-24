
        .org $0200
        
        LDX #$00                ; Initialize row counter
checkRows:
        LDA matrix, X           ; Load the starting address of the row
        STA currentRowPtr
        LDY #$00                ; Initialize column counter
checkCols:
        LDX #$00                ; Reset the row index
        LDA (currentRowPtr), Y  ; Load the value from the matrix
        STA tempValue           ; Store the value temporarily
        
        INX                     ; Move to the next row
        LDA (currentRowPtr), X  ; Load the value from the corresponding cell
        CMP tempValue           ; Compare it with the original value
        BNE notSymmetric        ; If not equal, jump to notSymmetric
        
        INY                     ; Move to the next column
        CPY #$04                ; Check if all columns have been checked
        BNE checkCols           ; If not, continue checking the current row
        
        INX                     ; Move to the next row
        INX
        CPX #$04                ; Check if all rows have been checked
        BNE checkRows           ; If not, continue checking the next row
        
        JMP symmetric           ; If reached here, matrix is symmetric
        
notSymmetric:
        JMP $FFFC              ; Jump to end of program
        
symmetric:
        JMP $FFFC              ; Jump to end of program
        
        .byte $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF
        
matrix:
        .byte $01, $02, $03, $04
        .byte $02, $02, $03, $04
        .byte $03, $03, $03, $04
        .byte $04, $04, $04, $04
