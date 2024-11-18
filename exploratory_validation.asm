
        .org $0600    ; start of program

START   LDX #0       ; initialize index to 0
        STX APPLICANT_NUMBER  ; store applicant number in memory
        LDA #0       ; clear accumulator
        STA APPLICANT_NAME    ; clear applicant name
        
INPUT_LOOP
        ; Prompt user to enter applicant name
        LDA #<APPLICANT_NAME_PROMPT
        STA PRINT_TEXT
        LDA #>APPLICANT_NAME_PROMPT
        STA PRINT_TEXT+1
        JSR PRINT_STRING
        
        LDA #<APPLICANT_NAME
        STA READ_STRING
        LDA #>APPLICANT_NAME
        STA READ_STRING+1
        JSR READ_STRING
        
        ; Display applicant name
        LDA #<APPLICANT_NAME
        STA PRINT_TEXT
        LDA #>APPLICANT_NAME
        STA PRINT_TEXT+1
        JSR PRINT_STRING
        
        ; Increment applicant number
        INX
        STX APPLICANT_NUMBER
        
        ; Ask user if they want to enter another applicant
        LDA #<ENTER_ANOTHER_APPLICANT
        STA PRINT_TEXT
        LDA #>ENTER_ANOTHER_APPLICANT
        STA PRINT_TEXT+1
        JSR PRINT_STRING
        
        LDA #<YES_NO_CHOICE
        STA VALID_CHOICE
        JSR ASK_YES_NO
        BEQ INPUT_LOOP   ; if user entered 'y', loop back to input
        
        ; Display all applicants
        LDA #<DISPLAY_APPLICANTS
        STA PRINT_TEXT
        LDA #>DISPLAY_APPLICANTS
        STA PRINT_TEXT+1
        JSR PRINT_STRING
        
        LDA #0
        STA INDEX
DISPLAY_LOOP
        LDA APPLICANT_ARRAY, X
        BEQ END_DISPLAY
        JSR PRINT_STRING
        INX
        JMP DISPLAY_LOOP
        
END_DISPLAY
        RTS
        
; Strings and Constants
APPLICANT_NUMBER
        .byte 0
APPLICANT_NAME
        .byte 0
APPLICANT_NAME_PROMPT
        .asciiz "Enter applicant name: "
ENTER_ANOTHER_APPLICANT
        .asciiz "Do you want to enter another applicant? (y/n): "
YES_NO_CHOICE
        .byte 0

; Subroutines
; Print a null-terminated string at location in PRINT_TEXT
PRINT_STRING
        LDX #0
PRINT_LOOP
        LDA PRINT_TEXT, X
        BEQ PRINT_DONE
        JSR PRINT_CHARACTER
        INX
        JMP PRINT_LOOP
PRINT_DONE
        RTS

; Print a single character in the accumulator
PRINT_CHARACTER
        ; Output character in A
        RTS
        
; Read string from user input into APPLICANT_NAME
READ_STRING
        ; Read string into APPLICANT_NAME
        RTS
        
ASK_YES_NO
        ; Ask user for 'y' or 'n' input
        ; Store result in VALID_CHOICE
        RTS

; Data
APPLICANT_ARRAY
        .byte 0 ; applicant data will be stored here
