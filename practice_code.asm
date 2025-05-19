
; Fitness Tracking System
;
; Features:
; - Track daily steps
; - Track daily calories burned
; - Display summary of daily activity
;
; Usage:
; - Enter daily steps when prompted
; - Enter daily calories burned when prompted
; - Press any key to display summary
;

.segment "CODE"
.org $2000

MAIN:
    ; Initialize variables
    LDA #0
    STA steps
    STA calories
    
    ; Input daily steps
    LDX #steps_prompt
    JSR PRINT_STRING
    JSR READ_NUMBER
    STA steps
    
    ; Input daily calories burned
    LDX #calories_prompt
    JSR PRINT_STRING
    JSR READ_NUMBER
    STA calories
    
    ; Display summary
    LDX #summary
    JSR PRINT_STRING
    JSR PRINT_NUMBER steps
    JSR PRINT_STRING
    JSR PRINT_NUMBER calories
    
    ; End program
    BRK

; Subroutines

; Print a null-terminated string pointed to by X
PRINT_STRING:
    LDA (X), Y
    BEQ PRINT_STRING_DONE
    JSR PRINT_CHAR
    INX
    JMP PRINT_STRING

PRINT_STRING_DONE:
    RTS

; Print a single character from A
PRINT_CHAR:
    STA $6000
    RTS

; Read a number from keyboard input
READ_NUMBER:
    LDX #0
    LDA #$00
    STA buffer
GET_CHAR:
    JSR READ_CHAR
    CMP #13   ; check if ENTER key pressed
    BEQ END_READ_NUMBER
    JSR PRINT_CHAR
    JSR STR_TO_NUM
    INX
    JMP GET_CHAR
END_READ_NUMBER:
    LDA buffer
    RTS

; Read a character from keyboard input
READ_CHAR:
    LDA $C000
    STA buffer, X
    INX
    RTS

; Convert string to number in A
STR_TO_NUM:
    LDA buffer
    CMP #48
    BCC STR_TO_NUM_DONE
    CMP #57
    BCS STR_TO_NUM_DONE
    SEC
    SBC #48
    RTS
STR_TO_NUM_DONE:
    RTS

; Data
.steps_prompt: .byte "Enter daily steps: $00", 0
.calories_prompt: .byte "Enter daily calories burned: $00", 0
.summary: .byte "Daily Steps: $00, Calories Burned: $00", 0
.steps: .byte 0
.calories: .byte 0
.buffer: .byte 0

.end
