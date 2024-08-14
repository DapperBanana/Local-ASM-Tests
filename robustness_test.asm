
LDX #0      ; Initialize index to 0
LDA #10     ; Initialize sum to 0
STA $80     ; Store sum at memory location $80
LDA #5      ; Load the number of elements in the list
STA $81     ; Store the number of elements at memory location $81

loop:
    LDA list, X    ; Load the next element from the list
    CLC            ; Clear the carry flag
    ADC $80        ; Add the element to the sum
    STA $80        ; Store the updated sum at memory location $80
    INX            ; Increment index
    CPX $81        ; Compare index to number of elements
    BNE loop       ; Branch if index is not equal to number of elements

    SEC               ; Set carry flag for division
    LDA $80           ; Load the sum
    LDX $81           ; Load the number of elements
    JSR divide        ; Call divide subroutine

    HLT               ; Halt the program

divide:
    LSR               ; Divide the sum by 2
    DEX               ; Decrement X register
    BNE divide        ; Loop till X is not zero
    RTS               ; Return from subroutine

list:
    .BYTE 5, 10, 15, 20, 25 ; List of elements

    .ORG $FFFA    ; Reset vector
    .WORD start

start:
    JMP loop      ; Jump to loop
