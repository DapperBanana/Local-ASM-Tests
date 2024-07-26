
START:
    LDA #0
    STA BALANCE

    LDA #5
    STA STOCK_PRICE

    JSR DISPLAY_MENU

LOOP:
    JSR GET_CHOICE

    CMP #1
    BEQ BUY_STOCK

    CMP #2
    BEQ SELL_STOCK

    CMP #3
    BEQ DISPLAY_BALANCE

    CMP #4
    BEQ EXIT

    JMP LOOP

BUY_STOCK:
    JSR DISPLAY_STOCK_PRICE
    JSR GET_AMOUNT

    LDA BALANCE
    CMP #0
    BEQ ERROR

    CMP AMOUNT
    BCC ERROR

    LDA BALANCE
    SEC
    SBC AMOUNT
    STA BALANCE

    LDA STOCK_PRICE
    SEC
    SBC AMOUNT
    STA STOCK_PRICE

    JSR DISPLAY_BALANCE
    JMP LOOP

SELL_STOCK:
    JSR DISPLAY_STOCK_PRICE
    JSR GET_AMOUNT

    LDA STOCK_PRICE
    SEC
    SBC AMOUNT
    STA STOCK_PRICE

    LDA BALANCE
    CLC
    ADC AMOUNT
    STA BALANCE

    JSR DISPLAY_BALANCE
    JMP LOOP

DISPLAY_BALANCE:
    LDA BALANCE
    STA $C000

    LDA #$C0
    STA $C001

    JSR $FFD2 ; Print accumulator as decimal

    RTS

GET_AMOUNT:
    LDA $"Enter amount: "
    STA $C000

    LDA #$C0
    STA $C001

    JSR $FFD2 ; Print accumulator as decimal

    JSR $FFBD ; Get user input

    RTS

DISPLAY_STOCK_PRICE:
    LDA STOCK_PRICE
    STA $C000

    LDA #$C0
    STA $C001

    JSR $FFD2 ; Print accumulator as decimal

    RTS

DISPLAY_MENU:
    LDA $"1. Buy stock"
    STA $C000

    LDA $"2. Sell stock"
    STA $C000

    LDA $"3. Display balance"
    STA $C000

    LDA $"4. Exit"
    STA $C000

    LDA #$C0
    STA $C001

    RTS

GET_CHOICE:
    LDA $"Enter choice: "
    STA $C000

    LDA #$C0
    STA $C001

    JSR $FFBD ; Get user input

    RTS

ERROR:
    LDA $"Error: Insufficient funds"
    STA $C000

    LDA #$C0
    STA $C001

    RTS

EXIT:
    RTS

    .ORG $C000
BALANCE: .BYTE 0
STOCK_PRICE: .BYTE 0
AMOUNT: .BYTE 0

    .ORG $FFD2
    .BYTE $4C

    .ORG $FFBD
    .BYTE $FF
