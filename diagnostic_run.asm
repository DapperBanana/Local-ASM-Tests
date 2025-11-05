
START    LDX #5         ; Load the number of sides of the pentagon
         LDA #10        ; Load the side length of the pentagon
         STA SIDE
         JSR MULT
         STA AREA
         JSR MULT
         JSR MULT
         JSR MULT
         JSR MULT
         CPY #2
         BNE *
         LDY AREA       ; Load the area of one of the pentagon's sides
         JSR MULT
         STA TMP
         LDA #5
         JSR MULT       ; Multiply by 5 to get the total area of all five sides
         STA AREA
         LDA #10        ; Load the height of the prism
         JSR MULT
         STA VOL        ; Store the volume of the prism
         RTS

MULT     JSR TMP2
         CLC            ; Clear carry flag
         ADC TMP        ; Add the result to the accumulation
         STA TMP        ; Store the result
         RTS


*        INX
         LDY TMP
         STY $02
         STX $00
         RTS

AREA     .BYTE 0
SIDE     .BYTE 0
VOL      .BYTE 0
TMP      .BYTE 0
TMP2     .BYTE 0

         .ORG $FFFC
         .WORD START
