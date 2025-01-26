
STACK_SIZE = 10
STACK_BASE = $0200

        .org $0200

        ; Initialize the stack pointer
        LDA #STACK_BASE + STACK_SIZE - 1
        STA $0100

        ; Push a value onto the stack
        LDA #10
        JSR PUSH_STACK
        
        ; Push another value onto the stack
        LDA #20
        JSR PUSH_STACK

        ; Pop a value from the stack
        JSR POP_STACK
        STA $FF

        ; Pop another value from the stack
        JSR POP_STACK
        STA $FE

        ; Exit the program
        BRK

PUSH_STACK:
        ; Decrement the stack pointer
        DEC $0100

        ; Store the value on the stack
        STA $0100

        RTS

POP_STACK:
        ; Load the value from the stack
        LDA $0100

        ; Increment the stack pointer
        INC $0100

        RTS
