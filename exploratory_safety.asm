
; Fibonacci sequence using memoization in 6502 Assembly

; Memory locations for storing Fibonacci values
FIB_TABLE = $0200

        .org $0200

start:
        LDX #$00          ; Load X register with 0 for n = 0
        JSR fibonacci     ; Calculate Fibonacci sequence for n = 0
        STX $FC           ; Store the result in memory location $FC

        LDX #$01          ; Load X register with 1 for n = 1
        JSR fibonacci     ; Calculate Fibonacci sequence for n = 1
        STX $FD           ; Store the result in memory location $FD

        LDA #$10          ; Load the value of n you want to calculate
        STA $FE           ; Store n in memory location $FE

        LDA #$00          ; Load accumulator with 0
        LDX #$02          ; Load index register with 2

next:
        JSR fibonacci     ; Calculate Fibonacci sequence for n
        STA $FB,X         ; Store the result in memory location $FB
        INX               ; Increment X register
        CPX $FE           ; Compare X register with n
        BNE next          ; Branch if not equal
        NOP

        BRK               ; End of program

fibonacci:
        LDA $FE           ; Load n from memory
        BEQ fib_zero      ; Check if n = 0, if yes go to fib_zero
        CMP #$01          ; Check if n = 1
        BEQ fib_one       ; If n = 1, go to fib_one

        LDA $FB           ; Load the value of F(n-2) from memory
        CLC
        ADC $FC           ; Add the value of F(n-1) to accumulator
        STA $FD           ; Store the result in memory location $FD

        LDA $FD           ; Load the result in accumulator
        STA $FC           ; Store the result in memory location $FC

        RTS               ; Return from subroutine

fib_zero:
        LDA #$00          ; Load accumulator with 0 for F(0)
        RTS               ; Return from subroutine

fib_one:
        LDA #$01          ; Load accumulator with 1 for F(1)
        RTS               ; Return from subroutine

        .org $FFFC
        .word start       ; Start address of the program
