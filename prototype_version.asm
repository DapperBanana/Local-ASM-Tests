
        .org $0200
start   LDX #$02            ; initialize X register for divisor
        STX divisor
        
input   LDA #<number        ; load low byte of number
        STA numberLow
        LDA #>number        ; load high byte of number
        STA numberHigh
        
        LDA #>divisor       ; load high byte of divisor
        STA divisorHigh
        LDA #<divisor       ; load low byte of divisor
        STA divisorLow
        
loop    JSR divide         ; call divide subroutine
        
        LDA numberLow      ; check if number is zero
        ORA numberHigh
        BEQ done           ; if number is zero, exit loop
        
        INC divisor         ; increment divisor
        BNE loop           ; branch to loop
        
done    BRK                ; exit program

divide  LDA #0             ; clear remainder
        STA remainder
        
        LDA numberLow      ; load low byte of number
        CLC        
        ADC #0             ; add zero to check if number is divisible by divisor
        CMP divisorLow     ; compare divisor with low byte of number
        BCC notdivisible   ; branch if not divisible
        BNE notdivisible
        
        LDA numberHigh     ; load high byte of number
        CLC
        ADC #0             ; add zero
        CMP divisorHigh    ; compare divisor with high byte of number
        BCC notdivisible   ; branch if not divisible
        
        LDA #1             ; if number is divisible, set remainder to 1
        STA remainder
        RTS
        
notdivisible
        LSR numberLow      ; shift number right to divide by 2
        ROR numberHigh
        LDX divisor        ; load divisor
        
        LDA remainder      ; check if remainder is zero
        BEQ done           ; if remainder is zero, exit divide subroutine
        
        LDA divisorLow     ; check if divisor is larger than number
        CMP numberLow
        BCC notfactor      ; branch if not prime factor
        BNE notfactor
        
        LDA divisorHigh
        CMP numberHigh
        BCC notfactor      ; branch if not prime factor
        RTS                ; return to loop
        
notfactor
        JMP divide         ; continue with divide subroutine

number  .word 999          ; input number to find prime factors
divisor .word 2            ; initial divisor
remainder .byte 0          ; remainder of division
numberLow .byte 0          ; low byte of number
numberHigh .byte 0         ; high byte of number
divisorLow .byte 0         ; low byte of divisor
divisorHigh .byte 0        ; high byte of divisor

        .end
