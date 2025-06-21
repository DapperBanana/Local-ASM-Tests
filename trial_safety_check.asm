
; Assume the points are stored as:
; Point A: X1, Y1, Z1
; Point B: X2, Y2, Z2

    .org $0200    ; Start address of the program

    LDX #0        ; Initialize sum to 0
    LDY #0
    LDA #0

    ; Calculate the squared differences
    LDA X1
    STA $10       ; Store X1 temporarily
    LDA Y1
    SEC
    SBC Y2        ; (X1 - X2)^2
    STA $11       ; Store result temporarily
    LDA Z1
    SEC
    SBC Z2        ; (Y1 - Y2)^2
    STA $12       ; Store result temporarily
    SEC
    LDA $10
    SBC X2        ; (Z1 - Z2)^2

    ; Add squared differences together
    CLC
    LDA $11
    ADC A
    TAY
    LDA $12
    ADC A
    TAX

    ; Calculate square root of the sum
    JSR sqrt      ; Call subroutine to calculate square root
    LDX result    ; Load result into X register

    ; Print the result
    JSR print    ; Call subroutine to print result

    ; End of program
    BRK

; Subroutine to calculate square root
sqrt:
    LDX #0        ; Initialize the result to 0
next_bit:
    ASL           ; Shift left to multiply current result by 2
    TAX
comp_sqr:
    LDA square, X    ; Load square of current result
    CMP tmp        ; Compare to squared sum
    BCS skip_add    ; If square > current result, skip addition
    SBC tmp        ; Subtract squared sum from current result
    INX            ; Increment result
skip_add:
    DEX            ; Decrement to next bit
    BNE comp_sqr   ; Loop until all bits are processed
    RTS

; Subroutine to print result
print:
    LDX result
    LDA #$30      ; ASCII offset for numbers
    CLC
print_loop:
    ADC #$01      ; Add offset to get ASCII character
    JSR $FFD2     ; Call KERNAL subroutine to print character
    DEX
    BNE print_loop
    RTS

; Data section
X1: .byte 1
Y1: .byte 2
Z1: .byte 3
X2: .byte 4
Y2: .byte 5
Z2: .byte 6
square: .byte 1, 4, 9, 16, 25, 36, 49, 64, 81 ; Squares of numbers 0-9
tmp: .byte 0, 0, 0, 0, 0, 0
result: .byte 0

