
        .org $0200
        
start   LDX #$06            ; Load X with the number of sides of the hexagon
        LDA #$00            ; Initialize the accumulator to 0
        STA $00             ; Store the accumulator at memory location $00 (area)
        
loop    CLC                 ; Clear the carry bit
        LDA $00             ; Load the current value of area
        ADC X               ; Add the current value of X (number of sides)
        STA $00             ; Store the new value of area
        DEX                 ; Decrement X
        BNE loop            ; Branch to loop if X is not 0
        
        LDA $00             ; Load the final value of area
        STA $01             ; Store it in memory location $01
        
end     NOP                 ; No operation, halt the program
        
        .end
