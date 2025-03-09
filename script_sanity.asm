
; Matrix Multiplication program for 2x2 matrices
; Inputs: Matrix A - 0x00, 0x01, 0x02, 0x03
;         Matrix B - 0x04, 0x05, 0x06, 0x07
; Outputs: Matrix C = A * B - 0x08, 0x09, 0x0A, 0x0B

.SETUP:
    LDA $00     ; Load A(0,0)
    CLC
    ADC $06     ; Add B(0,0)
    STA $08     ; Store C(0,0)

    LDA $01     ; Load A(0,1)
    ADC $07     ; Add B(1,0)
    STA $09     ; Store C(0,1)
    
    LDA $02     ; Load A(1,0)
    CLC
    ADC $04     ; Add B(0,1)
    STA $0A     ; Store C(1,0)

    LDA $03     ; Load A(1,1)
    ADC $05     ; Add B(1,1)
    STA $0B     ; Store C(1,1)

.END:
    BRK         ; End the program
