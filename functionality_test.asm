
; Program to calculate the area of a regular pentagonal prism
; Input: Side length of the pentagon and height of the prism
; Output: Area of the pentagonal prism

START:
    LDA #SIDE_LENGTH   ; Load the side length of the pentagon
    STA SIDE_LENGTH

    LDA #HEIGHT        ; Load the height of the prism
    STA HEIGHT

    ; Calculate the area of the pentagonal prism
    LDA SIDE_LENGTH
    JSR MULT               ; Multiply side length by 5 for the base area of the pentagon
    TAX
    LDA #5
    JSR MULT               ; Multiply the result by the height to get the total surface area
    TAX
    LDA #2
    JSR MULT               ; Multiply by 2 to get the final area
    STA AREA
    
    ; End of program
    BRK

MULT:
    SEC
    LDA #$00
    ADC $01
    STA $01
    LSR
    TAX
    LDA #$00
    EOR $00
    LSR
    TAX
    LDA #$00
    BPL LOOP_START
    SEC
    SBC SIDE_LENGTH
    INX
    BNE LOOP_START
    RTS

LOOP_START:
    SEC
    SBC #$00
    BNE LOOP_START
    RTS

SIDE_LENGTH: .BYTE 0
HEIGHT: .BYTE 0
AREA: .BYTE 0
