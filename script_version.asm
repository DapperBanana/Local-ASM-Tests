
; Fitness tracking system
; This program allows the user to input their daily exercise minutes and tracks their total
; exercise minutes for the week.

; Variables
exercise_hours     = $00         ; Total hours of exercise
exercise_minutes   = $01         ; Total minutes of exercise
exercise_week      = $02         ; Total exercise minutes for the week
input_minutes      = $03         ; Input minutes
input_char         = $04         ; Input character
input_counter      = $05         ; Input character counter

; Strings
prompt_hours       = "Enter exercise hours: "
prompt_minutes     = "Enter exercise minutes: "
tracking_message   = "Exercise tracked!"

; Program start
start:
    lda #$00
    sta exercise_hours
    sta exercise_minutes
    sta exercise_week

    jsr get_input_hours
    jsr get_input_minutes

calculate_total:
    lda exercise_minutes
    clc
    adc exercise_hours
    sta exercise_week

display_message:
    lda #<(tracking_message)
    ldy #>(tracking_message)
    jsr print_string

end_program:
    rts

; Get user input for exercise hours
get_input_hours:
    lda #<(prompt_hours)
    ldy #>(prompt_hours)
    jsr print_string

    lda #00
    sta input_counter

get_hours_loop:
    jsr get_input_char
    cmp #$0D    ; Check for Enter key
    beq get_hours_done
    
    jsr char_to_digit
    asl         ; Shift left to multiply by 2
    clc
    adc exercise_hours
    sta exercise_hours

    jmp get_hours_loop

get_hours_done:
    rts

; Get user input for exercise minutes
get_input_minutes:
    lda #<(prompt_minutes)
    ldy #>(prompt_minutes)
    jsr print_string

    lda #00
    sta input_counter

get_minutes_loop:
    jsr get_input_char
    cmp #$0D    ; Check for Enter key
    beq get_minutes_done

    jsr char_to_digit
    clc
    adc exercise_minutes
    sta exercise_minutes

    jmp get_minutes_loop

get_minutes_done:
    rts

; Get a single character input
get_input_char:
    jsr read_char
    jsr print_char
    rts

; Convert ASCII character to digit
char_to_digit:
    sec
    sbc #48
    rts

; Print a null-terminated string from memory
print_string:
    lda (lda),y
    beq print_string_done
    jsr print_char
    jmp print_string

print_string_done:
    rts

; Print a character to the screen
print_char:
    sta $ff00
    rts

; Read a character input
read_char:
    lda $ff02
    rts
