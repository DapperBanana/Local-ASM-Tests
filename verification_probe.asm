
; 6502 Assembly Traffic Simulation

RESET       .org $FFFC
            .word START

START       LDX #$00        ; Initialize loop counter
LOOP        LDA ROAD,X      ; Load data from road array
            STA SCREEN,X    ; Store data to screen array

            INX             ; Increment loop counter
            CPX #$20        ; Check if end of road array
            BNE LOOP        ; If not, continue loop

            JMP START       ; Restart simulation

ROAD        .byte "               |               "
SCREEN      .byte $00

            .org $2000
            .include "apple2.inc"
