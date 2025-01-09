
.temp_C equ $00        ; Storage for Celsius temperature
.temp_F equ $01        ; Storage for Fahrenheit temperature

LDA #25               ; Load Celsius temperature (25 degrees) into accumulator
STA temp_C            ; Store Celsius temperature

LDA temp_C            ; Load Celsius temperature into accumulator
CLC                   ; Clear carry flag
ADC #32               ; Add 32
STA temp_F            ; Store result in Fahrenheit
LDA temp_C            ; Load Celsius temperature into accumulator
ASL                   ; Multiply by 2
ADC temp_F            ; Add Fahrenheit temperature
STA temp_F            ; Store result

BRK                   ; End program
