
; Factorial program in 6502 Assembly

RAM_START  equ $0200
STACK_START  equ $FEFF
CR equ $0D

    .org RAM_START
    .entry start

factorial:            ; Recursive factorial function
    PHA               ; Push accumulator to stack
    LDA #1            ; Load 1 into accumulator
    CMP #$00          ; Compare with input value
    BEQ end           ; If input is 0, return 1
    SEC               ; Set carry flag
    SBC #1            ; Subtract 1 from input value
    JSR factorial     ; Call factorial function recursively
    PLA               ; Pop accumulator from stack
    CLC               ; Clear carry flag
    ADC factor        ; Add factor to accumulator
    RTS

start:
    LDX #$05          ; Assign the input value (e.g., n = 5)
    JSR factorial     ; Call factorial function
    STA result        ; Store the result in memory
    LDA result        ; Load the result to accumulator
    JSR print_result  ; Print the result
    BRK

print_result:
    PHA               ; Push accumulator to stack
    LDY #$00          ; Load Y register with 0
loop:
    LDA result        ; Load the result from memory
    CMP #$0A          ; Compare with newline character
    BEQ end_print     ; If newline, print done
    JSR print_char    ; Print the current character
    INY               ; Increase Y register by 1
    INC result        ; Move to the next character
    JMP loop          ; Continue printing
end_print:
    PLA               ; Pop accumulator from stack
    RTS

print_char:
    STA $FFD2        ; Write character to screen
    RTS

end:
    RTS

    .org STACK_START
    factor: .byte 0
    result: .byte 0

    .end
