
; 6502 Assembly program to find and print the smallest prime number greater than a given number

START   LDX #0          ; Initialize X register to 0
        LDA NUMBER      ; Load the given number into the accumulator
CHECK   INX             ; Increase X register by 1
        CPX #NUMBER     ; Compare X register with the given number
        BEQ NOT_PRIME   ; Branch if X register equals the given number
        JSR IS_PRIME    ; Call subroutine to check if the number is prime
        BNE CHECK       ; Branch if the number is not prime
        STA RESULT      ; Store the prime number in RESULT
NOT_PRIME
        LDA RESULT      ; Load the smallest prime number greater than the given number
        SEC             ; Set carry flag
        ADC #1          ; Add 1 to get the next prime number
        STA RESULT      ; Store the next prime number in RESULT
        LDA RESULT      ; Load the next prime number
        JSR PRINT       ; Call subroutine to print the number
        RTS             ; Return from subroutine

IS_PRIME PHA             ; Push accumulator onto the stack
        LDX #2          ; Initialize X register to 2
DIVIDE  CLC             ; Clear carry flag
        LDA #0          ; Load 0 into accumulator
        ADC RESULT      ; Add the current result
        BCS NOT_PRIME   ; Branch if carry is set
        CPX RESULT      ; Compare X register with the current result
        BEQ IS_PRIME    ; Branch if X register equals the current result
        CPX #0          ; Compare X register with 0
        BEQ NOT_PRIME   ; Branch if X register equals 0
        CPX #1          ; Compare X register with 1
        BEQ NOT_PRIME   ; Branch if X register equals 1
        DIV X           ; Divide the number by X register
        BNE DIVIDE      ; Branch if not divisible
        PLA             ; Pop accumulator from the stack
        LDA #1          ; Load 1 into accumulator
        RTS             ; Return from subroutine

PRINT   ; Print subroutine
        STA $FC         ; Print the next prime number (SMALLCHS)
        LDA #13         ; Load carriage return
        STA $FC         ; Print the carriage return
        RTS             ; Return from subroutine

NUMBER  .BYTE 10        ; Given number
RESULT  .BYTE 0         ; Result

        .ORG $FFFC
        .WORD START     ; Set reset vector
