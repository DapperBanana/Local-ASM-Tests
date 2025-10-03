
; Convert temperature from Celsius to Fahrenheit
;
; Formula: Fahrenheit = Celsius * 9/5 + 32

        .org $1000

start   LDX #0          ; Initialize index register to 0
loop    LDA TABLE,X     ; Load Celsius temperature from table
        STA TEMP        ; Store temperature in TEMP variable
        JSR CONVERT     ; Convert temperature to Fahrenheit
        STA RESULT,X    ; Store converted temperature in RESULT table
        INX             ; Increment index to move to next temperature
        CPX #9          ; Check if all temperatures are converted
        BNE loop        ; If not, repeat the loop
        BRK             ; End program

; Conversion subroutine
CONVERT LDA TEMP        ; Load Celsius temperature from TEMP
        LSR             ; Multiply by 9/5 (shift right)
        TAX             ; Save result in X register
        LDA TEMP        ; Load TEMP again
        ADC X           ; Multiply by 9/5 (add result from X register)
        LDA #32         ; Load 32 (Fahrenheit offset)
        ADC #0          ; Add 32 to get Fahrenheit temperature
        RTS             ; Return from subroutine

; Celsius temperature table
TABLE   .byte 0 ; 0 degrees Celsius
        .byte 10 ; 10 degrees Celsius
        .byte 20 ; 20 degrees Celsius
        .byte 30 ; 30 degrees Celsius
        .byte 40 ; 40 degrees Celsius
        .byte 50 ; 50 degrees Celsius
        .byte 60 ; 60 degrees Celsius
        .byte 70 ; 70 degrees Celsius
        .byte 80 ; 80 degrees Celsius

; Variables
TEMP    .byte 0
RESULT  .byte 0,0,0,0,0,0,0,0,0  ; Array to store converted temperatures

        .end
