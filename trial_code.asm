
            ORG     $0600

START       LDX     #8         ; number of sides (a nonagon has 8 sides)
            LDA     #2         ; length of one side (for example, 2 units)
            STA     SIDE
            LDA     #0         ; initializing area to 0
            STA     AREA
LOOP        LDA     SIDE
            CLC
            ADC     AREA
            STA     AREA
            DEX
            BNE     LOOP

            LDA     AREA
            TAX
            JSR     PRINT       ; print the result
            RTS

PRINT       PHA
            TXA
            PHA
            LDX     #$0A
PRINT_LOOP  LDA     #$30
            ADC     #0
            STA     $D012
            DEX
            BNE     PRINT_LOOP
            PLA
            PLA
            RTS

AREA        .BYTE   $00
SIDE        .BYTE   $00

            END     START
