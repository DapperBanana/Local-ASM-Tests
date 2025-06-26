
START    LDX #NUMS
         LDA #0
         STA MEDIAN  ; Initialize median to 0
         CLC
LOOP     LDA XNUMS,X
         ADC MEDIAN
         STA MEDIAN
         LSR
         DEX
         BNE LOOP
         INX
         BCC DONE
         ROR MEDIAN   ; Adjust median if number of elements is odd
DONE     RTS

NUMS     .BYTE 6   ; Number of elements in the list

XNUMS    .BYTE $05,$03,$09,$07,$01,$11  ; List of numbers

MEDIAN   .BYTE 0   ; Median of the list
