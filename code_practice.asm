
START LDX #0
      STX NUM
      LDX #10
      STX COUNT
LOOP  LDA #1000
      CMP NUM
      BCC THOUSANDS
      STA TEMP
      LDA #'M'
      JSR PRINT
THOUSANDS
      LDA #500
      CMP NUM
      BCC FIVE_HUNDRED
      STA TEMP
      LDA #'D'
      JSR PRINT
FIVE_HUNDRED
      LDA #100
      CMP NUM
      BCC HUNDREDS
      STA TEMP
      LDA #'C'
      JSR PRINT
HUNDREDS
      LDA #50
      CMP NUM
      BCC FIFTY
      STA TEMP
      LDA #'L'
      JSR PRINT
FIFTY
      LDA #10
      CMP NUM
      BCC TENS
      STA TEMP
      LDA #'X'
      JSR PRINT
TENS
      LDA #5
      CMP NUM
      BCC FIVE
      STA TEMP
      LDA #'V'
      JSR PRINT
FIVE
      LDX NUM
      TXA
      CMP #5
      BCS ONES
      STA TEMP
      LDA #'I'
      JSR PRINT
ONES  LDA NUM
      CMP #4
      BCS END
      STA TEMP
      LDA #'I'
      JSR PRINT
      STA TEMP
      LDA #'V'
      JSR PRINT
END   LDA #' '
      JSR PRINT
      LDA NUM
      STA TEMP
      JSR PRINT
      LDA #10
      STA COUNT
      SBX NUM
      BNE LOOP
      RTS

PRINT PHA
      STA TEMP
      JSR $FFD2
      PLA
      RTS
      
NUM   .BYTE 0
COUNT .BYTE 0
TEMP  .BYTE 0
