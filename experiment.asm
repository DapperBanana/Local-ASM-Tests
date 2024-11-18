
.org $0600  ; Start program at memory address $0600

LDX #0     ; Initialize X register to 0
LDY #100   ; Load Y register with the value 100 (Celsius temperature)
JSR ConvertToFahrenheit  ; Call the subroutine to convert Celsius to Fahrenheit

ConvertToFahrenheit:
    LDA Y       ; Load the Celsius temperature into the accumulator
    STA TempC   ; Store the Celsius temperature in memory location TempC
    CLC         ; Clear carry flag
    LDA TempC   ; Load the value stored in TempC back into the accumulator
    ASL         ; Multiply the value by 2 (Celsius * 2)
    ADC #$20    ; Add 32 to the result (Celsius * 2 + 32)
    STA TempF   ; Store the result in memory location TempF
    RTS         ; Return from subroutine

TempC .BYTE 0   ; Memory location to store Celsius temperature
TempF .BYTE 0   ; Memory location to store Fahrenheit temperature

.END        ; End of program
