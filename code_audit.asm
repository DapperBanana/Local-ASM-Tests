
    .org $0200  ; Start program at address $0200

    LDX #10    ; Load the number for which factorial is to be calculated
    JSR FACT   ; Call factorial function
    BRK        ; End program

FACT:
    CPX #0     ; Check if number is zero
    BEQ BASE   ; If true, return 1
    DEX        ; Decrement number
    JSR FACT   ; Recursive call to calculate factorial
    CLC        ; Clear carry flag
    ADC X      ; Calculate factorial
    RTS        ; Return from function

BASE:
    LDA #1     ; Load 1 as the base case
    RTS        ; Return from function
