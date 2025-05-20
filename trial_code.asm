
    .org $0200

start:
    LDA #22        ; Load Celsius temperature into A register
    STA celsius

    LDA celsius    ; Load Celsius temperature back into A register
    JSR convert    ; Call subroutine to convert Celsius to Fahrenheit

    STA fahrenheit ; Store Fahrenheit temperature in memory

    BRK            ; End program

convert:
    CLC            ; Clear carry flag

    LDA #9         ; Load constant 9 into A register
    ADC celsius    ; Add Celsius temperature to A register
    ASL            ; Multiply by 2 (shift left)
    ADC #160       ; Add constant 160 to A register

    RTS            ; Return from subroutine

celsius:
    .byte $00      ; Celsius temperature
fahrenheit:
    .byte $00      ; Fahrenheit temperature

    .end
