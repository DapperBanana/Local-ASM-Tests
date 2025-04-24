
START LDX #7      ; start with bit 7 (most significant bit)
    LDA number  ; load decimal number into accumulator
    STA binary   ; store decimal number as binary

CONVERT LSR       ; shift right to divide by 2
    ROL result  ; rotate left, store remainder in result
    DEX         ; decrement X register (go to next bit)
    BPL CONVERT ; loop until all bits are converted

DONE BRK         ; end program

number .BYTE 127 ; decimal number to convert (example: 127)
binary .BYTE 0   ; space to store binary number
result .BYTE 0   ; remainder of division

    .ORG $FFFC
    .DW START
