
; Matrix addition and subtraction operations

; Define the matrix A
.org $0200
A:      .byte $01, $02, $03, $04

; Define the matrix B
.org $0204
B:      .byte $05, $06, $07, $08

; Define the result matrices C and D
.org $0208
C:      .byte 0, 0, 0, 0
D:      .byte 0, 0, 0, 0

; Main program
.org $0200
start:
        LDA #$00        ; Initialize index to 0
        STA $FF         ; Store index in zeropage

add_loop:
        LDA $FF         ; Load index into A
        ASL             ; Multiply index by 2 to get offset
        TAX             ; Store result in X

        LDA A, X        ; Load data from matrix A
        CLC
        ADC B, X        ; Add data from matrix B
        STA C, X        ; Store result in matrix C

        LDA A, X        ; Load data from matrix A
        SEC
        SBC B, X        ; Subtract data from matrix B
        STA D, X        ; Store result in matrix D

        INX             ; Increment index
        INX
        CPX #$04        ; Compare index with 4
        BNE add_loop    ; If not equal, continue loop

end:
        BRK             ; End program

; Data section
.end
