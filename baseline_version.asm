
RAM_START equ $C000
JSR Start
BRK

Start:
    LDX #0          ; Initialize counter for matrix index
    LDY #0          ; Initialize row counter
    LDA #3
    STA RAM_START+0 ; Matrix A[0][0] = 3
    LDA #5
    STA RAM_START+1 ; Matrix A[0][1] = 5
    LDA #2
    STA RAM_START+2 ; Matrix A[1][0] = 2
    LDA #4
    STA RAM_START+3 ; Matrix A[1][1] = 4
    LDA #1
    STA RAM_START+4 ; Matrix B[0][0] = 1
    LDA #2
    STA RAM_START+5 ; Matrix B[0][1] = 2
    LDA #0
    STA RAM_START+6 ; Matrix B[1][0] = 0
    LDA #1
    STA RAM_START+7 ; Matrix B[1][1] = 1

OuterLoop:
    LDX #0          ; Reset inner loop counter
InnerLoop:
    LDA RAM_START,X ; Load value from matrix A
    ADD RAM_START+4,X ; Add value from matrix B
    STA RAM_START+8,X ; Store result in matrix C
    INX
    CPX #$04        ; Check if end of row
    BNE InnerLoop
    INY
    LDA RAM_START+4,Y
    ADD RAM_START+8,Y
    STA RAM_START+8,Y
    CPY #2          ; Check if end of matrix
    BNE OuterLoop
    RTS

ADD:
    CLC
    ADC RAM_START,X ; Add accumulator to value from matrix A
    STA RAM_START+8,X ; Store result in matrix C
    RTS

SUB:
    SEC
    SBC RAM_START,X ; Subtract accumulator from value in matrix A
    STA RAM_START+8,X ; Store result in matrix C
    RTS
