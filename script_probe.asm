
        ORG $0200

START:  LDA #$32        ; load 50 degrees Celsius into the accumulator
        STA CELSIUS     ; store it in memory location CELSIUS

        LDA CELSIUS     ; load the value from CELSIUS into the accumulator
        JSR CELSIUS_TO_FAHRENHEIT  ; call the subroutine to convert Celsius to Fahrenheit

        BRK             ; stop the program

CELSIUS_TO_FAHRENHEIT:
        ; Formula to convert Celsius to Fahrenheit:
        ; Fahrenheit = (Celsius * 9/5) + 32

        LDA CELSIUS     ; load the Celsius value into the accumulator
        CLC             ; clear the carry flag
        ADC #0          ; add 0 to keep the accumulator value in hexadecimal
        LSR             ; divide by 2 to multiply by 5
        LSR             ; divide by 2 again
        LSR             ; divide by 2 a third time
        ADC CELSIUS     ; add the original Celsius value
        STA FAHRENHEIT  ; store the result in memory location FAHRENHEIT

        CLC             ; clear the carry flag
        ADC #32         ; add 32 to convert to Fahrenheit
        STA FAHRENHEIT  ; store the final Fahrenheit value

        RTS             ; return from subroutine

CELSIUS: .BYTE $32       ; memory location to store Celsius value
FAHRENHEIT: .BYTE $00    ; memory location to store Fahrenheit value
