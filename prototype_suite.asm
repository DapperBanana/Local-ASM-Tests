
        ORG     $1000

RADIUS  .BYTE    $05          ; radius of the circle

        LDA     RADIUS       ; load the radius into the accumulator
        STA     $00          ; store the radius in memory location $00

        LDX     $00          ; load the radius back into X register
        DEY                   ; decrement Y register to prepare for multiplication
LOOP    TYA                   ; load Y register into accumulator
        CLC                   ; clear carry flag
        ADC     $01          ; add current value in memory location $01
        STA     $01          ; store the result back in memory location $01
        DEX                   ; decrement X register
        BNE     LOOP         ; branch to LOOP if X is not zero

        LDA     $01          ; load the result of multiplication into accumulator
        JSR     DIVIDE       ; call subroutine to divide the result by 2

        STY     $00          ; store the result in memory location $00

        BRK                   ; terminate program

DIVIDE  SEC                   ; set carry flag
        LSR                   ; shift accumulator one bit to the right
        BCC     DIVIDE       ; branch to DIVIDE if carry flag is clear
        RTS                   ; return from subroutine
