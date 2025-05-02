
STACK_SIZE = 10
STACK_POINTER = $F0
STACK_BASE = $00

; Push a value onto the stack
PUSH:
    LDA STACK_POINTER
    CMP #STACK_SIZE
    BCS STACK_OVERFLOW

    LDA $01    ; Load the value to push onto the stack
    STA STACK_BASE, X
    INX
    STA STACK_POINTER

    RTS

; Pop a value from the stack
POP:
    LDA STACK_POINTER
    BEQ STACK_UNDERFLOW

    DEX
    LDX STACK_POINTER
    LDA STACK_BASE, X
    STA $02    ; Store the popped value in a register

    STA STACK_POINTER

    RTS

STACK_OVERFLOW:
    ; Handle stack overflow error
    BRK

STACK_UNDERFLOW:
    ; Handle stack underflow error
    BRK

; Initialize the stack
INIT_STACK:
    LDA #$00
    STA STACK_POINTER

    RTS
