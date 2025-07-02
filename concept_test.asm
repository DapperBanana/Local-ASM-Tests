
        .org $0200

start   LDX #$00          ; Initialize X register to 0
        STX year          ; Store the year in memory address $00

        LDA year          ; Load the year into accumulator
        AND #$03          ; Check if year is divisible by 4
        BEQ is_leap_year  ; Branch if equal to zero

        LDA year          ; Load the year into accumulator
        AND #$07          ; Check if year is divisible by 100
        BEQ is_not_leap_year ; Branch if equal to zero

        LDA year          ; Load the year into accumulator
        AND #$0F          ; Check if year is divisible by 400
        BEQ is_leap_year  ; Branch if equal to zero

is_not_leap_year
        LDA #$00          ; Load 0 into accumulator
        STA result        ; Store the result in memory address $01
        JMP end           ; Jump to the end

is_leap_year
        LDA #$01          ; Load 1 into accumulator
        STA result        ; Store the result in memory address $01

end     BRK               ; Break

year    .byte $00
result  .byte $00

        .end
