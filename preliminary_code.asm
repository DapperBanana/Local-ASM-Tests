
; Weather Forecasting System

; Constants
EOL = $0D
SUNNY = "Sunny"
RAIN = "Rain"
SNOW = "Snow"

; Variables
weather forecast_result

 ; Initialize program
RESET:
    LDX #0
    STX forecast_result
    JSR GET_WEATHER
    JSR DISPLAY_RESULT

; Get random weather forecast  
GET_WEATHER:
    LDA #$00
    JSR RANDOM
    CMP #$10
    BCS SUNNY
    JMP RAIN

SUNNY:
    LDA #SUNNY
    STA forecast_result
    RTS

RAIN:
    LDA #RAIN
    STA forecast_result
    RTS

SNOW:
    LDA #SNOW
    STA forecast_result
    RTS

; Display result
DISPLAY_RESULT:
    LDX forecast_result
    JSR PRINT_STRING
    JSR NEW_LINE
    RTS

; Print a string to the screen
PRINT_STRING:
    LDY #$00

PRINT_LOOP:
    LDA (forecast_result), Y
    BEQ PRINT_DONE
    JSR PRINT_CHAR
    INY
    JMP PRINT_LOOP

PRINT_DONE:
    RTS

PRINT_CHAR:
    STA $FFD2
    RTS

; New line
NEW_LINE:
    LDA #'EOL
    JSR PRINT_CHAR
    RTS

; Generate random number
RANDOM:
    LDX #0
    STX $14
LOOP:
    LDA $14
    CLC
    ADC #$69
    STA $14
    CPX $14
    BNE LOOP
    RTS
