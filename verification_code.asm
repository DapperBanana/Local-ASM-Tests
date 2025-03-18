
START:
    LDX #00      ; Initialize stack pointer
    STX SP

    LDA #10
    JSR PUSH     ; Push value onto stack

    LDA #20
    JSR PUSH

    JSR POP      ; Pop value from stack into A
    STA RESULT1

    JSR POP
    STA RESULT2

    BRK

PUSH:
    TXA           ; Transfer X to A
    STA STACK,X   ; Store value on stack
    INX           ; Increment stack pointer
    TXA           ; Transfer A back to X
    RTS

POP:
    DEX           ; Decrement stack pointer
    TXA           ; Transfer X to A
    LDA STACK,X   ; Load value from stack
    RTS

STACK:
    .BYTE 10, 20

SP:
    .BYTE 00

RESULT1:
    .BYTE 00

RESULT2:
    .BYTE 00
