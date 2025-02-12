
        .org $0400

        LDX #$05        ; Load the number for which factorial needs to be calculated (e.g. 5)
        JSR factorial   ; Call the factorial subroutine

loop    BRA loop        ; Infinite loop

factorial
        PHA             ; Save the return address
        CPX #$01        ; Check if X is 1
        BEQ base_case   ; If X = 1, return 1
        DEX             ; Decrement X
        JSR factorial   ; Recursive call to calculate factorial(X-1)
        PLA             ; Reload the return address
        MUL factor      ; Multiply result by factor
        RTS             ; Return

base_case
        LDA #$01        ; Return 1
        RTS

factor  .byte $05      ; To store the result of multiplication

        .end
