
ORG $1000

START:  LDX #$07            ; set index to 7 (for 8-bit binary number)
        LDA #$00            ; clear accumulator
        LDY #$00            ; clear Y register
LOOP:   LSR                 ; shift right to get the LSB
        ROL $01             ; rotate left to store the current bit in memory
        DEY                 ; decrement Y register
        BPL LOOP            ; branch if the Y register is positive
        LDX #$07            ; reset index
ADD:    LDA $01             ; load the binary digit
        CMP #$01            ; compare with 1
        BEQ UPDATE          ; if equal, add to accumulator
        LDX #$01            ; otherwise skip
UPDATE: ASL                 ; shift left to multiply current value by 2
        TAX                 ; transfer result to X register
        CLC                 ; clear the carry flag
        ADC $00             ; add current value to accumulator
        STA $00             ; store the result in memory
        TAX                 ; transfer value from X register
        INY                 ; increment Y register
        BNE ADD             ; branch to Add
        RTS                 ; return
        
NUMBERS:    .BYTE $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

        .END START
