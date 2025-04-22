
; Check if a given year is a leap year using a function

        .org $2000

        LDA #0          ; Clear A register
        STA year        ; Initialize variable year to 0

        LDX #1984       ; Load X register with the year to check
        STX input_year  ; Store the input year in memory
        
        JSR is_leap_year ; Call the is_leap_year function
        
        LDA result      ; Load the result of the function
        BEQ not_leap    ; If result is 0, display "Not a leap year"
        
        LDA #1          ; If result is not 0, display "Leap year"
        JSR display_result
        
not_leap:
        LDA #0          ; Display "Not a leap year"
        JSR display_result
        
        BRK             ; End of program
        
is_leap_year:
        LDX input_year  ; Load the input year into X
        CPX #0          ; Check if the input year is zero
        BEQ not_a_leap  ; If it's zero, it's not a leap year
        
        LDA input_year  ; Load the input year into A
        SEC
        SBC #4          ; Check if the year is divisible by 4
        CMP #0
        BEQ is_leap     ; If it's divisible by 4, it could be a leap year
        
not_a_leap:
        LDA #0          ; Return false (not a leap year)
        STA result
        RTS             ; Return from function
        
is_leap:
        LDA #1          ; Return true (leap year)
        STA result
        RTS             ; Return from function
        
display_result:
        STA result      ; Store the result in memory
        LDA #result_msg ; Load the address of the result message
        JSR $FFD2       ; Call the KERNAL routine to print a string
        RTS             ; Return from function
        
        .dsb "Leap year"
result_msg:
        .byte $00
        .dsb "Not a leap year"
        
year:
        .byte $00
input_year:
        .byte $00
result:
        .byte $00
