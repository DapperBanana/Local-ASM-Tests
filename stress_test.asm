
START:
    LDX #0           ; Initialize the stack pointer
    STX STACK_PTR

    ; Push two values onto the stack
    LDA #10          ; Load a value to push onto the stack
    JSR PUSH
    
    LDA #20          ; Load another value to push onto the stack
    JSR PUSH

    ; Pop the values from the stack
    JSR POP          ; Pop the second value (20) from the stack
    JSR POP          ; Pop the first value (10) from the stack

    ; End of the program
    BRK

PUSH:
    LDA STACK_PTR
    CLC
    ADC #1           ; Increment stack pointer
    STA STACK_PTR
    
    LDX STACK_PTR
    STX STACK, X     ; Store the value at the top of the stack
    RTS

POP:
    LDX STACK_PTR
    LDA STACK, X     ; Load the value at the top of the stack
    STA RESULT       ; Store the popped value in RESULT
    
    DEX
    STX STACK_PTR    ; Decrement stack pointer
    RTS

; Data section
RESULT .BYTE $00     ; Variable to store popped value
STACK .BLKW 10       ; Stack data structure with a capacity of 10 values
STACK_PTR .BYTE $00  ; Stack pointer to keep track of the top of the stack
