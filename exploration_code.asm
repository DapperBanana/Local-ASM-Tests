
STACK_SIZE = 10
STACK_BASE = $FF

    .org $1000
    
    LDA #STACK_SIZE
    STA $FB
    LDA #STACK_BASE
    STA $FA

push:
    LDA $FB
    CMP #$00
    BEQ stack_overflow
    LDA $FA
    STA $FB
    STA $FA
    DEC $FB
    RTS

pop:
    LDA $FB
    CMP #STACK_SIZE
    BEQ stack_underflow
    INC $FB
    LDA ($FB)
    INC $FB
    RTS
    
stack_overflow:
    ; Handle stack overflow
    BRK

stack_underflow:
    ; Handle stack underflow
    BRK
    
    .org $2000
    ; Example usage of the stack data structure
    LDA #5
    JSR push
    LDA #10
    JSR push
    JSR pop ; Should return 10
    JSR pop ; Should return 5
