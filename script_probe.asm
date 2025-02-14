
; Factorial Calculator Program
; Input: Number to calculate factorial of in X register
; Output: Factorial result in accumulator

    .org $0600          ; Start program at memory address $0600

start:
    LDA #$05            ; Load the number 5 into the accumulator
    JSR factorial       ; Call the factorial subroutine
    STA result          ; Store the result in memory location result
    BRK                 ; Exit the program

factorial:
    CPX #$01            ; Compare X register to 1
    BEQ base_case       ; If X register is 1, return 1
    DEX                 ; Decrement X register
    JSR factorial       ; Recursive call to factorial subroutine
    CLC                 ; Clear the carry bit
    ADC result          ; Add the result of the recursive call to the accumulator
    RTS                 ; Return from subroutine

base_case:
    LDA #$01            ; Load 1 into accumulator
    RTS                 ; Return from subroutine

result: .byte 0          ; Memory location to store the factorial result

    .end                ; End of program
