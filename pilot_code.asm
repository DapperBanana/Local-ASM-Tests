
VAMPIRE_NUMBERS:

    LDA #0      ; Initialize counter
    STA counter

LOOP:

    LDA number   ; Load number into accumulator
    CMP #$A0     ; Check if number is less than 100
    BCC END_LOOP ; If number is less than 100, it cannot be a vampire number

    LSR          ; Shift right to divide by 10
    STA number   ; Store quotient back into number
    CLC
    ADC counter  ; Increment counter
    STA counter
    JMP LOOP     ; Repeat loop

END_LOOP:

    LDA counter  ; Load counter into accumulator
    CMP #$02     ; Check if number has even number of digits
    BCS NOT_VAMPIRE ; If number does not have even number of digits, exit
    
    LDX #0       ; Initialize X register to 0
    LDA #0       ; Initialize product to 0

CHECK_FACTORS:

    CMP number   ; Compare product with number
    BEQ IS_VAMPIRE ; If product is equal to number, it is a vampire number

    INY          ; Increment Y register
    CPY number   ; Compare Y with number
    BCS NOT_VAMPIRE ; If Y is greater than number, exit

    LDA number
    SEC
    SBC #1       ; Substract 1 from number
    STA number
    LDA VTBL,Y   ; Load factor from vampire table
    STA factor1
    LDA VTBL,X   ; Load factor from vampire table
    STA factor2
    JSR MULTIPLY ; Call multiply subroutine

    JMP CHECK_FACTORS ; Repeat

IS_VAMPIRE:
    ; Output message that number is a vampire number
    BRK

NOT_VAMPIRE:
    ; Output message that number is not a vampire number
    BRK

VTBL:
    .byte $11,$12,$21

MULTIPLY:
    ; Multiply factor1 and factor2
    ; Result will be stored in product variable
    BRK

number: .byte  12 ; Change this to check different numbers
counter: .byte 0
factor1: .byte 0
factor2: .byte 0
product: .byte 0
