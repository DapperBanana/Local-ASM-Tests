
        .org $0200             ; start program at address $0200

radius  .byte $05             ; radius of the cone
height  .byte $0A             ; height of the cone
volume  .word $0000           ; variable to store the volume

        LDA radius            ; load radius into accumulator
        STA $FE               ; store radius in zero page
        LDA height            ; load height into accumulator
        STA $FF               ; store height in zero page

        LDY #$00              ; initialize Y register to 0
        LDA $FE               ; load radius back into accumulator
        CLC                   ; clear carry flag
loop    DEY                   ; decrement Y register
        BNE loop              ; repeat loop until Y register reaches 0

        LDA $FF               ; load height back into accumulator
        ADC $FE               ; add radius to height
        LDX #$04              ; initialize X register to 4
power   DEX                   ; decrement X register
        BNE power             ; repeat loop until X register reaches 0

        STA volume            ; store final result in 'volume'

.end    JMP .end               ; infinite loop to end program
