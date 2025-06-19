
START       .org $1000
            JMP MAIN

FILENAME    .text "data.csv", $00

BUFFER      .block $20
INPUT       .block $20

MAIN        LDX #$00
LOOP        LDA FILENAME,X
            BEQ END
            STA INPUT,X
            INX
            JMP LOOP

END         LDA #$00
            STA INPUT,X

PRINT       LDX #$00
PRINT_LOOP  LDA INPUT,X
            BEQ DONE
            JSR $FFD2  ; subroutine to print character
            INX
            JMP PRINT_LOOP

DONE        RTS

            .end
