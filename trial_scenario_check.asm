
    .org $0200
start:
    LDX #0              ; Set X = 0
    LDY #0              ; Set Y = 0

loadString:
    LDA input,Y         ; Load character from input string
    BEQ reverseString   ; If end of string, start reversing
    INY                 ; Increment Y
    BNE loadString       ; Loop until end of string

reverseString:
    DEX                 ; Decrement X
    CPX #0              ; Check if at beginning of input string
    BMI exit            ; If at beginning, exit
    LDA input,X         ; Load character from end of input string
    STA output,Y        ; Store character in output string
    INY                 ; Increment Y
    JMP reverseString   ; Repeat until entire string is reversed

exit:
    BRK

input:
    .byte "Hello, World!",0  ; Input string
output:
    .byte 20                ; Output string, will be filled with reversed input string characters

    .end start
