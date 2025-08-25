
; Trapesoidal Prism Area Calculator
; Calculates the area of a trapezoidal prism using the formula:
; Area = ((a + b) / 2) * h

START:
    LDA #10     ; Load base 'a' into the A register
    STA BASE_A

    LDA #15     ; Load base 'b' into the A register
    STA BASE_B

    LDA #8      ; Load height 'h' into the A register
    STA HEIGHT

    ; Calculate area: ((a + b) / 2) * h
    LDA BASE_A  ; Load base 'a' into the A register
    CLC
    ADC BASE_B  ; Add base 'b' to the A register
    LSR         ; Divide by 2
    STA TEMP    ; Store the result in TEMP
    
    LDA TEMP
    ADC #0      ; Clear carry flag
    LDA HEIGHT  ; Load height 'h' into the A register
    JSR MULT    ; Multiply (a + b) / 2 by h

    ; Display the result
    STA RESULT  ; Store the result in RESULT
    JSR PRINT   ; Jump to the print subroutine

    ; End program
    BRK

; Subroutine to multiply two numbers
MULT:
    TAX         ; Transfer the value in A to X
    LDA #0      ; Initialize the result in A to 0
LOOP:
    CLC         ; Clear the carry flag
    LSR         ; Shift right
    BCC SHIFTOFF    ; If the lowest bit of the multiplier is 0, skip the next instruction
    CLC     ; Set the carry flag
    ADC TEMP    ; Add the current value of TEMP to the result
SHIFTOFF:
    ASL RESULT  ; Shift left the result
    DEX         ; Decrease the multiplier by 1
    BNE LOOP    ; If X is not 0, repeat the loop
    RTS         ; Return from subroutine

; Subroutine to print the result
PRINT:
    LDA RESULT  ; Load the result into the A register
    STA $FB     ; Store it at memory address $FB
    RTS

; Variables
BASE_A: .BYTE 0
BASE_B: .BYTE 0
HEIGHT: .BYTE 0
TEMP: .BYTE 0
RESULT: .BYTE 0

    .END
