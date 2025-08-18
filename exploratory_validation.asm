
ORG $0200

LDA #6         ; Load the value of n
JSR factorial  ; Call the factorial subroutine
BRK

factorial:
    PHA         ; Push the value of n to the stack
    CMP #1      ; Compare n to 1
    BEQ done    ; If n is 1, return 1
    SBC #1      ; Decrement n by 1
    JSR factorial  ; Recursive call to factorial subroutine
    PLA         ; Pop the value of n from the stack
    ADC ACC     ; Add n to the accumulator
    RTS

done:
    LDA #1      ; If n is 1, return 1
    RTS

; Start of program
JMP start

start:
    CLD
    SEI
    LDX #$FF
    TXS

    ; Your code here

    BRK

; End of program
ORG $FD00
