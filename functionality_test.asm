
; Celsius to Fahrenheit conversion program

; Define memory locations
Celsius    EQU $10  ; Input temperature in Celsius
Fahrenheit EQU $11  ; Output temperature in Fahrenheit

; Load input temperature in Celsius
    LDA #25        ; Input temperature in Celsius: 25 degrees
    STA Celsius

; Convert Celsius to Fahrenheit
    LDA Celsius    ; Load Celsius temperature into accumulator
    JSR Convert    ; Call the conversion subroutine
    STA Fahrenheit ; Store Fahrenheit temperature in memory

; Exit program
    BRK

; Subroutine to convert Celsius to Fahrenheit
Convert:
    ; Fahrenheit = Celsius * 9/5 + 32
    ASL            ; Multiply Celsius by 2 (shift left)
    ASL
    ASL
    ASL
    CLC
    ADC Celsius    ; Multiply Celsius by 2 and add Celsius value
    LDA #32        ; Add 32 to the result
    ADC #32
    ROR            ; Divide the result by 2 (shift right)
    ROR
    ROR
    ROR
    RTS            ; Return from subroutine

