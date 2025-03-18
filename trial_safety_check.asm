
    ORG $0200

START:
    ; Initialize variables
    LDX #0
    LDY #0

    ; Input the three sides of the triangle
    LDA SIDES1
    STA TRI1
    LDA SIDES2
    STA TRI2
    LDA SIDES3
    STA TRI3

    ; Calculate the perimeter of the triangle
    CLC
    LDA TRI1
    ADC TRI2
    ADC TRI3
    STA PERIMETER

    ; Calculate the semi-perimeter
    LSR PERIMETER
    ROR PERIMETER

    ; Calculate the area of the triangle using Heron's formula
    LDA PERIMETER
    SEC
    SBC TRI1
    STA TMP
    LDA PERIMETER
    SEC
    SBC TRI2
    STA TMP2
    LDA PERIMETER
    SEC
    SBC TRI3
    STA TMP3
    LDX TMP
    LDA TMP
    ADC TMP2
    ADC TMP3
    STA TMP4
    LDA TMP4
    LSR
    LSR
    STA AREA
    
    ; Output the area of the triangle
    LDA AREA
    STA OUTPUT
    
    ; Halt the program
    BRK

SIDES1: .BYTE 5
SIDES2: .BYTE 6
SIDES3: .BYTE 7

TRI1: .BYTE 0
TRI2: .BYTE 0
TRI3: .BYTE 0

PERIMETER: .BYTE 0
AREA: .BYTE 0
TMP: .BYTE 0
TMP2: .BYTE 0
TMP3: .BYTE 0
TMP4: .BYTE 0
OUTPUT: .BYTE 0

    RTS
