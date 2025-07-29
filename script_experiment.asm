
START:
    ; Initialize stack pointer
    LDX #STACK_SIZE
    TXS

    ; Push values onto the stack
    LDA #10
    JSR PUSH
    LDA #20
    JSR PUSH
    LDA #30
    JSR PUSH

    ; Pop values from the stack
    JSR POP
    JSR POP
    JSR POP

    ; End of program
    BRK

PUSH:
    ; Decrement stack pointer
    DEX
    TXS

    ; Store value on the stack
    STA $0100,X

    RTS

POP:
    ; Load value from the stack
    LDA $0100,X

    ; Increment stack pointer
    INX
    TXS

    RTS

STACK_SIZE = 16  ; Size of stack memory

    .org $FCFF
    .dw START
