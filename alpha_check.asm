
      .org $8000

start lda #0          ;initialize stock price
      sta stock_price

      lda #100        ;initialize player's cash balance
      sta cash_balance

      lda #0          ;initialize player's stock balance
      sta stock_balance

menu  lda #$9B        ;print menu options
      jsr $FFD2

      lda #$0A        ;read user input
      jsr $FFCF
      
      cmp #1          ;check user input
      beq buy_stock
      cmp #2
      beq sell_stock
      cmp #3
      beq display_balance
      cmp #4
      beq quit
      
      jmp menu

buy_stock lda #$F0     ;print prompt for stock price
      jsr $FFD2

      lda stock_price
      jsr $FFD6       ;print current stock price

      lda #1
      jsr $FFCF       ;read user input for quantity to buy

      lda stock_price
      sec
      sbc #10         ;calculate total cost
      sta total_cost

      lda total_cost
      cmp cash_balance
      bcc purchase_stock  ;check if player has enough cash

      lda #$FA         ;print error message
      jsr $FFD2
      jmp menu

purchase_stock lda total_cost  ;subtract total cost from cash balance
      sec
      sbc cash_balance
      sta cash_balance

      lda stock_balance
      clc
      adc #1          ;add 1 to stock balance
      sta stock_balance

      jmp menu

sell_stock lda stock_balance  ;print prompt for stock price
      jsr $FFD2

      lda stock_price
      jsr $FFD6       ;print current stock price

      lda #2
      jsr $FFCF       ;read user input for quantity to sell

      lda stock_price
      sec
      sbc #10         ;calculate total value
      sta total_value

      lda stock_balance
      cmp #0
      beq sell_error

      lda total_value
      cmp stock_balance
      bcc sell_error  ;check if player has enough stock to sell

      lda #$FB         ;print error message
      jsr $FFD2
      jmp menu

sell_error lda total_value  ;add total value to cash balance
      clc
      adc cash_balance
      sta cash_balance

      lda stock_balance
      sec
      sbc #1          ;subtract 1 from stock balance
      sta stock_balance

      jmp menu

display_balance lda #$F1    ;print cash balance
      jsr $FFD2

      lda cash_balance
      jsr $FFD6

      lda #$F2        ;print stock balance
      jsr $FFD2

      lda stock_balance
      jsr $FFD6

      jmp menu

quit  lda #$FE         ;exit the program
      rts

stock_price .byte 0
cash_balance .byte 0
stock_balance .byte 0
total_cost .byte 0
total_value .byte 0

      .end
