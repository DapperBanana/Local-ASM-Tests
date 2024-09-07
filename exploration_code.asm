
    ; Simple stack data structure implementation using 6502 Assembly

    STACK_SIZE = 10
    
    ; Memory locations for stack pointer and stack data
    STACK_POINTER = $F0
    STACK_DATA = $00

    ORG $1000
    JMP START

STACK:
    .DS STACK_SIZE

START:
    LDX #STACK_SIZE-1    ; Setting stack pointer to top of stack
    STX STACK_POINTER

    ; Pushing data onto stack
    LDA #4
    JSR PUSH_DATA
    LDA #7
    JSR PUSH_DATA

    ; Popping data from stack
    JSR POP_DATA
    STA $0800
    JSR POP_DATA
    STA $0801

    ; End of program
    BRK

PUSH_DATA:
    DEX
    STX STACK_POINTER
    LDA #STACK_DATA,X
    STA STACK,X
    RTS

POP_DATA:
    LDA STACK,X
    INX
    STX STACK_POINTER
    RTS
