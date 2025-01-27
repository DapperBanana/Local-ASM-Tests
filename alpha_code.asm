
; 6502 assembly program to simulate a basic text-based weather forecasting system

; Variables
weather_data:
    .byte 25, 30, 28, 32, 27, 31, 24   ; Sample weather forecast data for 7 days

; Constants
message_welcome:
    .text "Welcome to the Weather Forecasting System"
message_menu:
    .text "1. Check today's weather"
    .text "2. Check tomorrow's weather"
    .text "3. Exit"
message_weather_today:
    .text "Today's weather is: "
message_weather_tomorrow:
    .text "Tomorrow's weather is: "

; Program start
    lda #0
    sta $fb
    jsr print_message_welcome

program_loop:
    jsr print_message_menu

    lda $fb
    cmp #1
    beq check_weather_today
    cmp #2
    beq check_weather_tomorrow
    cmp #3
    beq exit_program
    jmp program_loop

check_weather_today:
    lda weather_data, x
    jsr print_message_weather_today
    inx
    jmp program_loop

check_weather_tomorrow:
    lda weather_data, x
    jsr print_message_weather_tomorrow
    inx
    jmp program_loop

exit_program:
    rts

; Subroutines
print_message_welcome:
    ldx #0
print_char_welcome:
    lda message_welcome, x
    beq done_welcome
    jsr print_char
    inx
    jmp print_char_welcome
done_welcome:
    rts

print_message_menu:
    ldx #0
    lda #0x0a
    jsr print_char
print_char_menu:
    lda message_menu, x
    beq done_menu
    jsr print_char
    inx
    jmp print_char_menu
done_menu:
    rts

print_message_weather_today:
    ldx #0
print_char_weather_today:
    lda message_weather_today, x
    beq done_weather_today
    jsr print_char
    inx
    jmp print_char_weather_today
done_weather_today:
    lda weather_data, x
    jsr print_num
    lda #0x0d
    jsr print_char
    rts

print_message_weather_tomorrow:
    ldx #0
print_char_weather_tomorrow:
    lda message_weather_tomorrow, x
    beq done_weather_tomorrow
    jsr print_char
    inx
    jmp print_char_weather_tomorrow
done_weather_tomorrow:
    lda weather_data, x
    jsr print_num
    lda #0x0d
    jsr print_char
    rts

print_char:
    ldy #0x02
    sta $fb
    jsr $ffd2
    cpy #0
    bpl print_char
    rts

print_num:
    ldx #0
print_digit:
    lda weather_data, x
    and #0x0f
    ora #0x30
    jsr print_char
    ror
    ror
    ror
    ror
    inx
    cpx #7
    bne print_digit
    rts
