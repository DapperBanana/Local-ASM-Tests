
        .org $0200        ; Start address of program
        LDA #$00          ; Initialize accumulator to 0
        LDY #$00          ; Initialize Y register to 0
        LDX #$0A          ; Set n to 10 (change this value to calculate sum for a different value of n)
loop:
        CLC               ; Clear carry bit
        ADC Y             ; Add Y to accumulator
        INY               ; Increment Y
        CPX #$00          ; Check if we have reached n
        BNE loop          ; If not, continue looping
        STA $0201         ; Store the result in memory location $0201
halt:
        JMP halt          ; Infinite loop
