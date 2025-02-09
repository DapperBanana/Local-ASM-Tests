
LDA radius
JSR calculateArea
STA area
HLT

calculateArea:
    LDX #2
    LDA radius
    STA temp
    CLC
loop:
    ROR temp
    LSR area
    LSR area
    DEX
    BNE loop
    RTS

area: .BYTE 0
radius: .BYTE 5
temp: .BYTE 0
