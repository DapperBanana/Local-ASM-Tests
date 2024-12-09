
; Factorial calculation using recursion in 6502 Assembly
; Input: The number whose factorial is to be calculated should be stored in memory location $00
; Output: The factorial of the input number will be stored in memory location $01

                .org    $0200

start           LDX     #10         ; Load the number whose factorial is to be calculated
                STX     $00         ; Store the number in memory location $00

                JSR     factorial   ; Call the factorial subroutine
                
end             BRK                 ; Terminate the program

factorial       CMP     #1          ; Check if the number is 1
                BEQ     return      ; If yes, return 1 as its factorial

                DEX                 ; Decrement the number
                STX     $00         ; Store the decremented number
                JSR     factorial   ; Recursively call the factorial routine
                
                LDA     $00         ; Load the decremented number
                CLC
                ADC     $01         ; Add the previous factorial result
                STA     $01         ; Store the new factorial
                
return          RTS                 ; Return from the subroutine

                .org    $FFFA
                .word   start
