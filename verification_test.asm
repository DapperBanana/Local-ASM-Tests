
        ORG     $8000

AREA    EQU     $00      ; Variable to store the area of the hexagon
SIDE    EQU     $01      ; Variable to store the length of the side of the hexagon

        LDA     #6       ; Load the number of sides of the hexagon
        STA     SIDE     ; Store it in SIDE
        LDA     #10      ; Load the length of the side of the hexagon
        STA     AREA     ; Store it in AREA

        LDA     AREA     ; Load the length of the side
        CLC
        ADC     AREA     ; Multiply the length of the side by 6 (6 * side)
        TAX                ; Store the result in X register
        LDA     AREA     ; Load the length of the side
        ADC     AREA
        TAX                ; Add the result to the X register
        LDA     AREA     
        ADC     AREA
        TAX                ; Add the result to the X register

        LDX     AREA     ; Load the result from X register
        STX     AREA     ; Store it in AREA

END     JMP     END      ; End the program
