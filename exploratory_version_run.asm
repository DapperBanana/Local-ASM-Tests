
START        LDX #$00            ; Initialize X register to store the previous Fibonacci number
             LDY #$01            ; Initialize Y register to store the current Fibonacci number
             STX $C002          ; Store the previous Fibonacci number (0) in memory at $C002
             STY $C003          ; Store the current Fibonacci number (1) in memory at $C003
             LDA #$00            ; Initialize accumulator to store the sum of even Fibonacci numbers
             STA $C004          ; Store the sum in memory at $C004
             LDY #$FF            ; Initialize Y register to store the limit
             STY $C000          ; Store the limit in memory at $C000

CALC_FIB      CLC                 ; Clear carry flag
             LDA $C002          ; Load previous Fibonacci number
             ADC $C003          ; Add to current Fibonacci number
             STA $C005          ; Store the new Fibonacci number in memory at $C005
             STX $C002          ; Update previous Fibonacci number
             STY $C003          ; Update current Fibonacci number
             CMP $C000          ; Compare current Fibonacci number to the limit
             BCC CHECK_EVEN      ; Branch if below limit

             JMP DONE            ; Jump to done if limit is reached

CHECK_EVEN   LDA $C005          ; Load new Fibonacci number
             AND #$01            ; Check if even
             BEQ ADD_SUM         ; Branch if even

             JMP CALC_FIB        ; Continue calculating Fibonacci number

ADD_SUM      LDA $C005          ; Load new Fibonacci number
             ADC $C004          ; Add to sum
             STA $C004          ; Update sum

             JMP CALC_FIB        ; Continue calculating Fibonacci number

DONE         BRK                 ; Break and end program
