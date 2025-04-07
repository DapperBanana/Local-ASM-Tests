
START    LDA #0          ; Initialize random sentence
         STA SENTENCE
         LDA #0
         STA SENTENCE+1

         LDY #0          ; Initialize current state
NEXT_WORD
         LDA SENTENCE
         CLC             ; Load next word from chain
         ADC STATE,Y
         STA STATE,Y
         LDA SENTENCE+1
         ADC STATE+1,Y
         STA STATE+1,Y

         LDA #0          ; Count possible next words
         LDX #$FF
COUNT    INX
         BNE .DONE
         INY
.DONE    CMP #END
         BNE COUNT

         LDX STATE       ; Randomly choose next word
         LDA RAND,X
         TAX

         LDA #0          ; Update chain and sentence
         CLC
         ADC STATE
         STA SENTENCE
         LDA #0
         ADC STATE+1
         STA SENTENCE+1
         STA STATE
         STA STATE+1
         STA STATE+2
         STA STATE+3

         TXA
         LDY #0
         LDA CHAINS,X
         CLC
         ADC STATE+2,Y
         STA STATE+2,Y
         INY
         LDA CHAINS+1,X
         ADC STATE+3,Y
         STA STATE+3,Y

         LDX STATE
         LDA CHAINS,X
         STA SENTENCE+2

         CPX #END        ; Stop generation if reaching end
         BNE NEXT_WORD

         RTS

STATE    .byte 0,0,0,0  ; Four bytes represent current state
SENTENCE .byte 0        ; Generated sentence
RAND     .byte $10,$20,$50,$80,$FF,$70,$30,$A0,$C0,$60
CHAINS   .byte "this is the begin",0
         .byte "end of the sentence",0
END      .byte $FF
