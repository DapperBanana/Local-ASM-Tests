
    ; Program to convert temperature from Celsius to Fahrenheit

    ORG $0200 ; Start execution at memory location $0200

    LDA #25 ; Load the Celsius temperature value (e.g. 25)
    STA Celsius ; Store the Celsius temperature value

    LDA Celsius
    JSR ConvertToTemperature ; Call subroutine to convert Celsius to Fahrenheit

    LDA Fahrenheit ; Load the Fahrenheit temperature value
    BRK ; Exit program

ConvertToTemperature:
    TAX ; Transfer Celsius value to X register
    CLC ; Clear carry flag

ConvertLoop:
    ADC #9 ; Add 9 to Celsius value
    DEX ; Decrement X register
    BNE ConvertLoop ; Loop until X register reaches 0

    STA Fahrenheit ; Store the Fahrenheit value
    RTS ; Return from subroutine

Celsius: .BYTE 0 ; Define variable to store Celsius temperature
Fahrenheit: .BYTE 0 ; Define variable to store Fahrenheit temperature

    .END ; End of program
