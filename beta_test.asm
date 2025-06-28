
        ORG    $1000                ; Start address of program

Main    LDX    #0                   ; Initialize X register to 0
Input   JSR    GETTEMP              ; Get user input temperature in Celsius

        LDA    TEMP                 ; Load input temperature
        STA    CELSIUS              ; Store input temperature in Celsius

        JSR    CALCFAHRENHEIT       ; Convert Celsius to Fahrenheit

        LDA    FAHRENHEIT           ; Load converted temperature
        JSR    DISPTEMP             ; Display converted temperature
        BRK                         ; End program

GETTEMP LDA    #$01                 ; Load 01 into accumulator
        JSR    $FFEF                ; Call KERNAL subroutine to get user input
        STA    TEMP                 ; Store user input temperature
        RTS                         ; Return from subroutine

CALCFAHRENHEIT LDA  CELSIUS           ; Load Celsius temperature
                CLC
                ADC  #$0201          ; Add 32 and multiply by 9/5
                TAX
                LDA  #$06
                ADC  #$165
                TAX
                LDA  #$00
                ADC  #$02
                TAX
                STA  FAHRENHEIT      ; Store converted temperature
                RTS

DISPTEMP
        LDX    FAHRENHEIT           ; Load Fahrenheit temperature
        JSR    $FFD2                ; Call KERNAL subroutine to display value in X register
        RTS

TEMP    .BYTE  $00                   ; Variable to store input temperature
CELSIUS .BYTE  $00                   ; Variable to store input temperature in Celsius
FAHRENHEIT .BYTE $00                 ; Variable to store converted temperature

        END                         ; End of program
