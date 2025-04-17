
; Quadratic equation: ax^2 + bx + c = 0
; Use the quadratic formula: x = (-b ± sqrt(b^2 - 4ac)) / 2a

ORG $0200  ; Start of program

    LDA #10     ; Assign a value for a (coefficient of x^2)
    STA COEFF_A
    
    LDA #5      ; Assign a value for b (coefficient of x)
    STA COEFF_B
    
    LDA #-3     ; Assign a value for c (constant term)
    STA COEFF_C
    
    LDA COEFF_B ; Load b (coefficient of x) into accumulator
    ASL         ; Multiply b by 2 (for calculating b^2 later)
    STA TEMP    ; Store the result in TEMP
    
    LDA TEMP    ; Load b^2 into accumulator
    ASL         ; Multiply b^2 by 2 (for calculating 4ac later)
    STA TEMP    ; Store the result in TEMP
    
    LDA COEFF_A ; Load a (coefficient of x^2) into accumulator
    ASL         ; Multiply a by 2 (for calculating 4ac later)
    STA TEMP2   ; Store the result in TEMP2
    
    LDA TEMP    ; Load b^2 into accumulator
    SEC         ; Set carry flag for subtraction
    SBC TEMP2   ; Calculate b^2 - 4ac
    STA DISC    ; Store the result in DISC (discriminant)
    
    LDA DISC    ; Load the discriminant into accumulator
    BMI NO_ROOT ; If discriminant is negative, no real roots
    
    LDA COEFF_B ; Load b (coefficient of x) into accumulator
    SEC         ; Set carry flag for subtraction
    SBC DISC    ; Calculate -b - sqrt(discriminant)
    STA ROOT_1  ; Store the first root in ROOT_1
    
    LDA COEFF_B ; Load b (coefficient of x) into accumulator
    CLC         ; Clear carry flag for addition
    ADC DISC    ; Calculate -b + sqrt(discriminant)
    STA ROOT_2  ; Store the second root in ROOT_2

NO_ROOT:
    BRK         ; End of program

COEFF_A:    .BYTE 0
COEFF_B:    .BYTE 0
COEFF_C:    .BYTE 0
DISC:       .WORD 0
TEMP:       .BYTE 0
TEMP2:      .BYTE 0
ROOT_1:     .BYTE 0
ROOT_2:     .BYTE 0

