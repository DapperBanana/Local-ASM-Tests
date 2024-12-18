
AREA equ $5000     ; Memory location to store the area
SIDE_LENGTH equ $5002   ; Memory location to store the length of each side
APOTHEM equ $5004       ; Memory location to store the apothem of the hendecagon

START:
    LDA #11            ; Load the number of sides of the hendecagon
    STA SIDE_LENGTH    ; Store it in SIDE_LENGTH
    LDA #$02           ; Load the length of one of the sides of the hendecagon
    STA $5006          ; Store it in memory location $5006
    LDA #$01           ; Load the apothem of the hendecagon
    STA APOTHEM        ; Store it in APOTHEM

    JSR CALC_AREA      ; Calculate the area of hendecagon

END:
    NOP                ; End of program

CALC_AREA:
    LDA SIDE_LENGTH
    CLC
    ADC #$01           ; Add 1 to the number of sides to avoid division by zero
    STA SIDE_LENGTH

    LDA #360           ; Load the number of degrees in a circle
    STA $5008          ; Store it in memory location $5008

    LDA SIDE_LENGTH
    ASL                ; Multiply the length of each side by 2
    STA $500A          ; Store the result in memory location $500A

    LDA $5008          ; Load the number of degrees in a circle
    STA $500C          ; Store it in memory location $500C

LOOP:
    LDA APOTHEM
    LSR                ; Divide the apothem by 2
    STA $500E          ; Store the result in memory location $500E

    LDA $500C
    SEC
    SBC SIDE_LENGTH    ; Subtract the length of each side from the number of degrees
    STA $500C          ; Store the result in memory location $500C

    LDA $500C
    SEC
    SBC SIDE_LENGTH    ; Subtract the length of each side from the number of degrees
    STA $500C          ; Store the result in memory location $500C

    LDA $500E
    STA APOTHEM        ; Update the apothem

    DEC SIDE_LENGTH    ; Decrement the number of sides
    BNE LOOP           ; Loop until all sides have been processed

    LDA $500A
    CLC
    ADC AREA          ; Add the partial area to the total area
    STA AREA 

    RTS               ; Return from subroutine
