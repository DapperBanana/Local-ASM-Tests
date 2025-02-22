
SECTOR_RADIUS .BYTE 10
SECTOR_ANGLE  .BYTE 45

; Constants for calculations
PI            =  3.14159
RADIANS_TO_DEGREES = 57.29578

    .TEXT
start:
    LDA SECTOR_RADIUS    ; Load radius into accumulator
    STA radius

    LDA SECTOR_ANGLE     ; Load angle into accumulator
    STA angle

    ; Calculate area of sector
    JSR calculateSectorArea

    ; Print the result
    LDA result_high
    JSR PRINT_HEX        ; Print high byte of result
    LDA result_low
    JSR PRINT_HEX        ; Print low byte of result

    RTS

calculateSectorArea:
    ; Calculate the area of the sector
    LDA #PI               ; Load PI into accumulator
    STA temp1             ; Store PI in temp1
    LDA angle             ; Load angle into accumulator
    STA temp2             ; Store angle in temp2
    JSR convertDegreesToRadians ; Convert angle from degrees to radians
    STA temp2             ; Store radians in temp2

    LDA radius
    STA temp3             ; Store radius in temp3
    LDA temp3             ; Load radius into accumulator
    CLC                   ; Clear carry flag
    ADC temp3             ; Double the radius
    STA temp4             ; Store the doubled radius in temp4

    LDA temp2             ; Load radians into accumulator
    LSR                   ; Divide angle in half
    STA temp5             ; Store half angle in temp5

    LDA temp4             ; Load doubled radius into accumulator
    LDA temp2             ; Load radians into accumulator
    STA temp4             ; Store radians in temp4

    LDA temp4             ; Load doubled radius into accumulator
    JSR multiply          ; Multiply angle by radius^2
    STA temp6             ; Store area in temp6

    LDA temp6             ; Load area into accumulator
    LSR                   ; Divide by 2
    STA result_low        ; Store low byte of result
    LDA #$00              ; Load 0 into accumulator
    ADC temp6             ; Add the area to itself divided by 2
    STA result_high       ; Store high byte of result

    RTS

convertDegreesToRadians:
    LDA temp2             ; Load angle into accumulator
    JSR multiply          ; Multiply angle by RADIANS_TO_DEGREES
    RTS

multiply:
    PHA                   ; Push accumulation to stack
    LDA #0                ; Load 0 into accumulator
multiply_loop:
    ASL                   ; Double the accumulator
    BCC no_rotate         ; Branch if carry flag is clear
    LDA temp3             ; Load the multiplicand into accumulator
    ADC temp4             ; Add the product
no_rotate:
    ROL                   ; Rotate accumulator left
    DEC temp5             ; Decrement loop counter
    BNE multiply_loop     ; Branch back to multiply_loop if not zero
    PLA                   ; Pull accumulation from stack
    RTS

result_low:
    .BYTE $00
result_high:
    .BYTE $00

temp1:
    .BYTE $00
temp2:
    .BYTE $00
temp3:
    .BYTE $00
temp4:
    .BYTE $00
temp5:
    .BYTE $00
temp6:
    .BYTE $00

radius:
    .BYTE $00
angle:
    .BYTE $00

