
    .org $0200  ; start address of the program

start:
    LDX #$0      ; initialize X to zero (sum of sides)
    LDA #10      ; initialize A to 10 (number of sides)
    
loop:
    CLC          ; clear carry flag
    ADC #40      ; add the length of each side (in this case, assuming sides are all equal to 40)
    DEX          ; decrement X (number of sides)
    BNE loop     ; loop until we add up all the sides
    
    LSR          ; shift the result to divide by 2
    STA result   ; store the result in memory
    NOP          ; delay slot for STA
    
    BRK          ; exit program

result:
    .byte $00    ; store the final result in memory
    
    .end
