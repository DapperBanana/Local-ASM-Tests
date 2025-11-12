
ORG $0200

START:  LDX #$00     ; Initialize X register to store sum of digits
        LDA $0201    ; Load input number from memory into accumulator
LOOP:   BEQ DONE     ; If input number is 0, exit loop
        AND #$0F     ; Mask out higher nibble of input number
        CLC         
        ADC X        ; Add the digit to the sum stored in X register
        STA X        ; Store the updated sum in X register
        LSR          ; Shift input number right by 1 nibble
        LSR
        LSR
        LSR
        BNE LOOP     ; Loop until all digits have been processed
        LDA $0201    ; Load input number again
        CLC
        CMP X        ; Compare sum with input number
        BEQ YES       ; If they are equal, input number is Harshad number
NO:     LDA #$00     ; Load 0 into accumulator (false)
DONE:   STA $0202    ; Store result in memory location
        RTS

YES:    LDA #$01     ; Load 1 into accumulator (true)
        JMP DONE     ; Jump to finish

END:    .END
