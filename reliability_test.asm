
ORG $0200

    ; Load the address of the array into X register
    LDX #<array
    LDY #>array

    ; Load the length of the array into the Accumulator
    LDA #5

outerLoop:
    ; Reset the index register Y
    LDY #0

innerLoop:
    ; Load the first number into the Accumulator
    LDA (X),Y

    ; Compare with the next number
    CLC
    INY
    CMP (X),Y

    ; Swap the numbers if needed
    BCC continue
    STA temp
    DEY
    STA (X),Y
    LDA temp
    INY
    STA (X),Y

continue:
    ; Move to the next number
    INY

    ; Check if reached the end of the array
    CPY #5
    BNE innerLoop

    ; Move to the next number in the outer loop
    INX
    DEX
    CPX #<array+5
    BNE outerLoop

    BRK

array:
    .byte 8, 3, 5, 2, 7
    temp: .byte 1

    .org $FFFA
    .word $0200
