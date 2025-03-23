
        .org $0200  ; start address
        
        LDX #0     ; initialize row index
CheckSymmetry:
        LDA Matrix, X  ; load element (i,j) from matrix
        STA Temp      ; store it in Temp
        
        INX           ; increment column index
        CPX #3        ; check if end of row
        BNE Continue
        
        LDY #0        ; initialize inner row index
CheckRow:
        LDA Matrix, Y     ; load element (j,i) from matrix
        CMP Temp          ; compare with element (i,j)
        BNE NotSymmetric
        
        INY               ; increment inner row index
        CPY #3            ; check if end of row
        BNE Continue2
        
        INX               ; move to next column
Continue:
        CPX #3            ; check if end of row
        BNE CheckSymmetry
        
        RTS
        
NotSymmetric:
        LDA #0             ; set carry flag to indicate matrix is not symmetric
        RTS
        
Continue2:
        INX               ; move to next column
        JMP CheckSymmetry

Matrix:
        .db 1, 2, 3
        .db 2, 4, 5
        .db 3, 5, 6
Temp:
        .ds 1
