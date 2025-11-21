
        .org $0200           ; Start address of the program

start   LDX #$32             ; Load the Celsius temperature value (e.g., 50 degrees)
        JSR TO_FAHRENHEIT   ; Call the subroutine to convert Celsius to Fahrenheit
        STX Celsius         ; Store the Celsius temperature
        STY Fahrenheit      ; Store the Fahrenheit temperature

loop    JMP $0200           ; Loop indefinitely

TO_FAHRENHEIT
        LDA #$5              ; Load the constant value 5
        SEC                  ; Set the carry flag
        SBC Celsius          ; Subtract the Celsius temperature value
        CLC                  ; Clear the carry flag
        ADC #$9C             ; Add the constant value 9C (198 in decimal)
        ASL                  ; Multiply the result by 2
        STA Fahrenheit      ; Store the result in the Fahrenheit register
        RTS                  ; Return from subroutine

Celsius .byte $00            ; Location to store input Celsius temperature
Fahrenheit .byte $00         ; Location to store output Fahrenheit temperature
