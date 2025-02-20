
; 6502 Assembly program to calculate the area of a circle given its radius

; Using the formula: Area = Pi * r^2

GET_RADIUS:
    LDA #00          ; Clear the accumulator
    STA RADIUS       ; Store 0 in the memory location RADIUS
    LDA #00          ; Clear the accumulator
    STA RADIUS+1     ; Store 0 in the memory location RADIUS+1

    LDX #00          ; Clear the X register
LOOP:
    LDA RADIUS+1,X   ; Load the number from RADIUS into the accumulator
    BEQ INPUT_RADIUS ; If the number is 0, jump to INPUT_RADIUS
    INC RADIUS+1,X   ; Increment the number in RADIUS
    BNE CALC_AREA    ; Branch to CALC_AREA

; Input the radius from the user
INPUT_RADIUS:
    LDA #0C          ; Print message: "Enter the radius: "
    JSR PRINT_STRING
    JSR READ_NUMBER  ; Read the number entered by the user
    STA RADIUS       ; Store the number in the memory location RADIUS
    LDA #00
    STA RADIUS+1     ; Clear the memory location RADIUS+1

; Calculate the area of the circle
CALC_AREA:
    LDA RADIUS       ; Load the value from RADIUS into the accumulator
    JSR MULTIPLY     ; Multiply the radius by itself
    STA AREA         ; Store the result in the memory location AREA
    LDA RADIUS+1     ; Load the value from RADIUS+1 into the accumulator
    JSR MULTIPLY     ; Multiply the radius by itself
    STA AREA+1       ; Store the result in the memory location AREA+1

    LDA #03          ; Load the value 3 into the accumulator
    STA TEMP         ; Store the value in the memory location TEMP
    JSR DIVIDE       ; Divide the result by 3

    LDA #21          ; Print message: "The area of the circle is: "
    JSR PRINT_STRING
    JSR PRINT_NUMBER ; Print the area calculated
    RTS              ; Return from subroutine

; Subroutine to multiply two 8-bit numbers
MULTIPLY:
    LDX #0C          ; Initialize loop counter
    LDA #00          ; Clear the accumulator
    STA RESULT       ; Store 0 in the memory location RESULT
LOOP_MULTIPLY:
    LDA RADIUS       ; Load the radius into the accumulator
    ROL              ; Rotate the accumulator left
    BCC SKIP_ADD      ; If carry bit is not set, jump to SKIP_ADD
    CLC              ; Clear the carry flag
    JSR ADD          ; Add the radius to the result
SKIP_ADD:
    DEX              ; Decrement loop counter
    BNE LOOP_MULTIPLY ; Branch back to LOOP_MULTIPLY if counter is not zero
    RTS              ; Return from subroutine

; Subroutine to divide an 16-bit number by an 8-bit number
DIVIDE:
    LDA #00          ; Clear the accumulator
    STA QUOTIENT     ; Store 0 in the memory location QUOTIENT
    STA REMAINDER    ; Store 0 in the memory location REMAINDER
    LDX #00          ; Clear the X register
DIV_LOOP:
    LDA AREA,X       ; Load the 16-bit number into the accumulator
    SEC              ; Set the carry flag
    SBC TEMP         ; Subtract the divisor from the number
    STA AREA,X       ; Store the result back in AREA
    INX              ; Increment the X register
    CPX #02          ; Compare X register to 2
    BNE DIV_LOOP     ; Branch to DIV_LOOP if X is not equal to 2
    RTS              ; Return from subroutine

; Subroutine to add an 8-bit number to a 16-bit result
ADD:
    CLC              ; Clear the carry flag
    ADC RESULT       ; Add the radius to the result
    STA RESULT       ; Store the result in the memory location RESULT
    RTS              ; Return from subroutine

; Memory locations
RADIUS   .BYTE  00, 00   ; Memory location to store radius entered by user
AREA     .WORD  0000     ; Memory location to store the area of the circle
TEMP     .BYTE  00       ; Memory location to store temporary values
RESULT   .BYTE  00       ; Memory location to store result of multiplication
QUOTIENT .BYTE  00       ; Memory location to store quotient of division
REMAINDER .BYTE  00      ; Memory location to store remainder of division
