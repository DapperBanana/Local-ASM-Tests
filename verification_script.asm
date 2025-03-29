
    ; Program to calculate the area of a trapezoid
    ; Formula: Area = ((base1 + base2) / 2) * height
    
    .text
    .globl main
    
main:
    ; Load base1, base2, and height values
    LDX #base1
    LDY #base2
    LDA #height
    
    ; Calculate the sum of base1 and base2
    CLC
    LDA (X),Y
    ADC A, #(base2 - base1)
    
    ; Calculate ((base1 + base2) / 2)
    LSR A
    
    ; Multiply by height
    ASL A
    STA result
    
    ; Store the result in memory
    STA result
    
    ; Halt program
    BRK
    
    .data
base1:  .byte 10
base2:  .byte 20
height: .byte 5
result: .byte 0
