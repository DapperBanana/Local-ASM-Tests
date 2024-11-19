
START:
    LDA #25          ; load 25 degrees Celsius
    STA tempC        ; store in tempC variable
    JSR celsiusToFahrenheit  ; convert Celsius to Fahrenheit
    BRK

celsiusToFahrenheit:
    LDA tempC        ; load Celsius temperature
    CLC
    ADC #$4B         ; multiply by 9/5 (approx. 1.8) and add 32
    STA tempF        ; store result in tempF variable
    RTS

tempC: .BYTE 0        ; variable to store Celsius temperature
tempF: .BYTE 0        ; variable to store Fahrenheit temperature
