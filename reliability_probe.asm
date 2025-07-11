
; Factorial calculation program in 6502 Assembly

        .org  $0200           ; Start program at memory address $0200

start:
        LDA   #5              ; Set the number for which to calculate factorial
        JSR   factorial       ; Call the factorial subroutine
        BRK                   ; End program

factorial:
        CMP   #1              ; Check if the number is 1
        BEQ   base_case       ; If yes, return 1
        SEC                   ; Set carry flag for multiplication
        SBC   #1              ; Subtract 1 from the number
        JSR   factorial       ; Recursively call factorial with the decreased number
        CLC                   ; Clear carry flag before multiplying
        ADC   #0              ; Add 0 to carry to get correct value
        LDX   #0              ; Clear X register to store result
multiply_loop:
        CLC                   ; Clear carry flag
        ADC   #0              ; Add the number to X register
        DEX                   ; Decrement X
        BNE   multiply_loop   ; Repeat until X = 0
        RTS                   ; Return from subroutine

base_case:
        LDA   #1              ; Load 1 into accumulator
        RTS                   ; Return from subroutine

        .end
