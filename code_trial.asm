
; Matrix dimensions
ROWS = 2
COLS = 2

; Define the matrices
matrix1     .byte 1, 2,   ; Matrix 1
            .byte 3, 4

matrix2     .byte 5, 6,   ; Matrix 2
            .byte 7, 8

result      .byte 0, 0,   ; Result matrix
            .byte 0, 0

; Load the matrices into memory
    LDX #0
loadMatrix:
    LDA matrix1, X
    STA $0100, X       ; Load Matrix 1 at memory location $0100
    LDA matrix2, X
    STA $0120, X       ; Load Matrix 2 at memory location $0120
    INX
    CPX #ROWS*COLS
    BNE loadMatrix

; Perform matrix addition
    LDX #0
addMatrix:
    LDA $0100, X       ; Load element from Matrix 1
    CLC
    ADC $0120, X       ; Add element from Matrix 2
    STA result, X      ; Store result in result matrix
    INX
    CPX #ROWS*COLS
    BNE addMatrix

; Perform matrix subtraction
    LDX #0
subMatrix:
    LDA $0100, X       ; Load element from Matrix 1
    SEC
    SBC $0120, X       ; Subtract element from Matrix 2
    STA result, X      ; Store result in result matrix
    INX
    CPX #ROWS*COLS
    BNE subMatrix

; Display the result matrix
    LDX #0
displayMatrix:
    LDA result, X
    ; Display the result, for example by writing to memory locations $0140 and $0141
    STA $0140, X
    INX
    CPX #ROWS*COLS
    BNE displayMatrix

    BRK

; End of program
