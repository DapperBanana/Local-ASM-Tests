
ORG $0200  ; Start program at memory address $0200

    LDA #$00   ; Initialize sum to 0
    STA RESULT

    LDX #10    ; Set n to 10 (change this value to calculate sum of different n)

LOOP:
    CLC        ; Clear the carry flag
    ADC X      ; Add X to the accumulator
    STA RESULT ; Store the result in RESULT
    DEX        ; Decrement X
    BNE LOOP   ; Branch back to LOOP if X is not zero

    BRK        ; End program

RESULT:
    .BYTE $00  ; Reserve a byte for the result

    .ORG $FFFA  ; Set up reset vector
    .WORD $0200 ; Set reset vector to program start address

