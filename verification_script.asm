
; Calculate the area of a regular hendecagon
; Side length of the hendecagon = 10 units

START:
    LDA #11               ; Number of sides of the hendecagon
    STA SIDES
    
    LDA #10               ; Side length of the hendecagon
    STA SIDE_LENGTH
    
    JSR CALC_APOTHEM      ; Calculate the apothem of the hendecagon
    JSR CALC_AREA         ; Calculate the area of the hendecagon
    
    ; Display the area of the hendecagon
    LDA AREA
    STA $6000             ; Store the area in memory location $6000
    
    ; Halt the program
    BRK

CALC_APOTHEM:
    LDX #0                ; Initialize X register to zero
    
    ; Calculate the apothem of the hendecagon
    ; Apothem = (Side length / 2) * tan(180 / number of sides)
    LDA SIDE_LENGTH
    ASL                   ; Multiply side length by 2
    STA TEMP1
    
    LDA SIDES
    SEC
    SBC #180
    TAY                   ; Y = (180 - SIDES)
    
    TYA                   ; Copy Y to A
    STA TEMP2
    
    LDA #0
    STA TEMP3
    STA TEMP4
    
CALC_APOTHEM_LOOP:
    ASL TEMP1              ; Shift left to multiply by 2
    ADC TEMP3              ; Add TEMP3 to the product of TEMP1
    
    ; Check if Y is zero
    CPY #0
    BEQ CALC_APOTHEM_DONE
    
    CLC
    ADC TEMP2              ; Add TEMP2 to the product
    STA TEMP3
    DEY
    JMP CALC_APOTHEM_LOOP
    
CALC_APOTHEM_DONE:
    LDA TEMP3
    STA APOTHEM            ; Store the apothem
    
    RTS

CALC_AREA:
    LDX #0                ; Initialize X register to zero
    
    ; Calculate the area of the hendecagon
    ; Area = 0.5 * Perimeter * Apothem
    LDA SIDES
    CLC
    ADC #1                 ; Increment by 1 to include the last side
    ASL
    TAY                    ; Y = 2 * (SIDES + 1)
    
    LDA SIDE_LENGTH
    STA TEMPA
    
    LDA APOTHEM
    STA TEMPB
    
    LDA #0
    STA TEMPX
    STA TEMPY
    
CALC_AREA_LOOP:
    TYA
    CLC
    ADC TEMPY
    STA TEMPY
    
    CPY #0
    BEQ CALC_AREA_DONE
    
    CLC
    ADC TEMPA
    STA TEMPX
    DEY
    JMP CALC_AREA_LOOP
    
CALC_AREA_DONE:
    LDA TEMPY
    CLC
    ADC AREA                ; Accumulate the result in AREA
    
    RTS

; Variables
SIDES      .BYTE 0
SIDE_LENGTH .BYTE 0
APOTHEM    .BYTE 0
AREA       .BYTE 0
TEMP1      .BYTE 0
TEMP2      .BYTE 0
TEMP3      .BYTE 0
TEMP4      .BYTE 0
TEMPA     .BYTE 0
TEMPB     .BYTE 0
TEMPX     .BYTE 0
TEMPY     .BYTE 0
