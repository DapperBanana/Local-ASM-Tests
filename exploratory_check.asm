
        ORG     $0200
START:  LDX     #2              ; Start factor at 2
        LDA     #NUMBER         ; Load the number to find prime factors of
        STA     VALUE
FINDFACTOR:
        CPX     VALUE           ; Compare factor to number
        BCS     END             ; If factor > number, end
        JSR     DIVIDE          ; Divide number by factor
        BEQ     PRIME           ; If result = 0, factor is a prime factor
        INX                     ; Increment factor
        JMP     FINDFACTOR

DIVIDE: LDA     VALUE           ; Load number
        SEC
        SBC     #0              ; Subtract factor
        STA     VALUE
        LSR
        LSR
        BMI     DIVDONE         ; If result is negative, we are done
        JMP     DIVIDE

DIVDONE:RTS                     ; Return from divide

PRIME:  LDA     #0              ; Load accumulator with 0
        STA     $0200           ; Store accumulator in memory location $0200
        JMP     START           ; Restart the process

END:    BRK

NUMBER: .BYTE   27              ; Number to find prime factors of
VALUE:  .BYTE   0               ; Variable to store the current value being processed

        .END
