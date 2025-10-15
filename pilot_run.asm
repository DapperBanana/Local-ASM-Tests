
    .org $1000
    
main:
    lda #0
    sta weather_input
    
    jsr get_input
    jsr get_weather_forecast
    jsr display_weather_forecast
    
    rts

get_input:
    lda #<weather_input_message
    ldx #>weather_input_message
    jsr print_message
    
    lda #weather_input
    jsr read_input
    
    rts

get_weather_forecast:
    lda weather_input
    cmp #1
    beq sunny
    cmp #2
    beq cloudy
    cmp #3
    beq rainy
    bne unknown
    
sunny:
    lda #<sunny_message
    ldx #>sunny_message
    jsr print_message
    rts
    
cloudy:
    lda #<cloudy_message
    ldx #>cloudy_message
    jsr print_message
    rts
    
rainy:
    lda #<rainy_message
    ldx #>rainy_message
    jsr print_message
    rts
    
unknown:
    lda #<unknown_message
    ldx #>unknown_message
    jsr print_message
    rts

display_weather_forecast:
    lda #<forecast_message
    ldx #>forecast_message
    jsr print_message
    rts

read_input:
    lda #0
    jsr $FFCF
    sta weather_input
    rts

print_message:
    jsr $FFD2
    rts

weather_input_message:
    .text "Enter the weather forecast (1 - sunny, 2 - cloudy, 3 - rainy): "
    .byte $00
    
sunny_message:
    .text "The weather forecast is: sunny"
    .byte $00
    
cloudy_message:
    .text "The weather forecast is: cloudy"
    .byte $00
    
rainy_message:
    .text "The weather forecast is: rainy"
    .byte $00
    
unknown_message:
    .text "Unknown weather forecast"
    .byte $00
    
forecast_message:
    .text "Thanks for using the weather forecasting system"
    .byte $00
