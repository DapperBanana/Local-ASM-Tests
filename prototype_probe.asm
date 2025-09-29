
; Random password generator program in 6502 assembly
; Generates a random password of given length

START    LDX #0              ; Initialize index X to 0
         LDA #8              ; Set password length to 8 (change as needed)
         STA LENGTH

GENERATE LDA #$EA            ; Seed the random number generator
         ASL A
         CLC
         ADC $D5
         STA $D5

NEXTCHAR LDA $D5              ; Generate random character
         ROL
         TAX
         LDA $D4,X
         STA PASSWORD,X

         INX
         CPX LENGTH          ; Check for password length
         BCC GENERATE        ; Loop until password length is reached

         RTS

; Random character table
         .BYTE $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50
         .BYTE $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$61,$62,$63,$64,$65,$66

PASSWORD .BLKB 8
LENGTH   .BYTE 0

         .ORG $FFFC
         .WORD START
