
; Define constants
YEAR equ $00       ; Year input
IS_LEAP_YEAR equ $01  ; Flag to indicate if year is a leap year

; Define function to check if a year is a leap year
CHECK_LEAP_YEAR:
    lda YEAR         ; Load year input
    cmp #$04         ; Check if year is divisible by 4
    beq .is_leap_year ; If divisible by 4, check next condition
    rts              ; Otherwise, return with IS_LEAP_YEAR flag as false
    
.is_leap_year:
    lda YEAR         ; Load year input
    cmp #$100        ; Check if year is divisible by 100
    beq .is_not_leap_year  ; If divisible by 100, check next condition
    lda YEAR         ; Load year input
    cmp #$400        ; Check if year is divisible by 400
    beq .set_leap_year    ; If divisible by 400, set IS_LEAP_YEAR flag as true
    rts              ; Otherwise, return with IS_LEAP_YEAR flag as false

.is_not_leap_year:
    rts              ; Return with IS_LEAP_YEAR flag as false

.set_leap_year:
    lda #$01         ; Set IS_LEAP_YEAR flag as true
    rts              ; Return with IS_LEAP_YEAR flag as true

; Main program
START:
    ; Input year to check
    ldx #$00         ; Set input index
    lda #2024        ; Load year to check (change this to test other years)
    sta YEAR         ; Store year input
    
    ; Call function to check if year is a leap year
    jsr CHECK_LEAP_YEAR

    ; Check result of leap year check
    lda IS_LEAP_YEAR ; Load IS_LEAP_YEAR flag
    beq .is_not_leap_year_output ; If flag is false, jump to output not leap year
    jmp .is_leap_year_output ; If flag is true, jump to output leap year

.is_not_leap_year_output:
    lda #0           ; Load result for not leap year
    ; Output not leap year result (e.g. store in memory or print)

.is_leap_year_output:
    lda #1           ; Load result for leap year
    ; Output leap year result (e.g. store in memory or print)

    ; End program
    rts              ; Return from main program

