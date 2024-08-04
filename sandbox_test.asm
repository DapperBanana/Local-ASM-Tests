
    LDX #0         ; initialize index register to 0
    LDA num        ; load the number to be squared into the accumulator
    STA numCopy    ; store a copy of the number
loop:
    STA result     ; store the result in memory
    CLC            ; clear the carry flag
    LSR            ; divide accumulator by 2
    ROR            ; shift results by 1
    CMP x          ; compare with index register
    BCC skip       ; branch if carry = 0
    LDA numCopy    ; load the copy of the number back into the accumulator
    CLC            ; clear carry flag
    ADC result     ; add current result to the accumulator
    STA result     ; store new result
skip:
    INX            ; increment index register
    CPX numCopy    ; compare with the copy of the number
    BCC loop       ; branch back to loop if not finished
    RTS            ; return from subroutine

num:
    .byte 25       ; change this value to the number you wish to find the square root of
numCopy:
    .byte 0
result:
    .byte 0
x:
    .byte 0
