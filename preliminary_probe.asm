
START LDX #0          ; Initialize index to 0
    LDY #1          ; Initialize Fibonacci number 1 to 1
    STY RESULT+1    ; Store current Fibonacci number 1
LOOP
    STY RESULT      ; Store current Fibonacci number 2
    CLC             ; Clear carry flag
    ADC RESULT+1    ; Add previous Fibonacci number
    STY RESULT+1    ; Store sum as new Fibonacci number
    INX             ; Increment index
    CPX COUNT       ; Compare index to total number of terms
    BNE LOOP        ; Loop until index is equal to total number of terms
    RTS             ; Return from subroutine

COUNT .BYTE 10       ; Number of Fibonacci terms
RESULT .BYTE 0,0     ; Storage for Fibonacci numbers
