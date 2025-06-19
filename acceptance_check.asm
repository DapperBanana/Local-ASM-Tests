
        .org $0200

start   LDX #10          ; Set the number for which to calculate the factorial
        JSR factorial    ; Call the factorial subroutine
        BRK

factorial   CPX #0         ; Check if X is 0
            BEQ done       ; If so, return 1 as the factorial of 0 is 1
            DEX            ; Decrement X
            PHA            ; Push the current value of X onto the stack
            JSR factorial  ; Call factorial recursively with X-1
            PLA            ; Pop the previous value of X from the stack
            INX            ; Increment X
            MUL            ; Multiply the previous value of X with the current value of X
            RTS

done        LDA #1         ; Load the value 1
            RTS

        .end
