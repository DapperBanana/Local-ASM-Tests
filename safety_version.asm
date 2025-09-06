
.org $0200

START:
    LDX #0          ; Initialize user's balance
    STX BALANCE

MENU:
    LDA #<MENU_TEXT ; Load menu text
    STA TEXT_POINTER
    LDA #>MENU_TEXT
    STA TEXT_POINTER+1
    
DISPLAY_MENU:
    JSR PRINT_TEXT  ; Display menu options
    
    LDA #0
    STA INPUT       ; Clear input variable
    
    JSR INPUT_CHAR  ; Get user input
    
    CMP #'1'        ; Check for option 1 - Buy stock
    BEQ BUY_STOCK
    
    CMP #'2'        ; Check for option 2 - Sell stock
    BEQ SELL_STOCK
    
    JMP MENU        ; Return to menu if no valid option
    
BUY_STOCK:
    LDA #STOCK_PRICE ; Load stock price
    CLC
    ADC BALANCE     ; Add user's balance
    STA TOTAL       ; Store total cost
    
    LDA #<STOCK_OWNED ; Load stock owned
    STA STOCK_POINTER
    LDA #>STOCK_OWNED
    STA STOCK_POINTER+1

    JSR PRINT_TEXT  ; Display buy stock text
    
    JSR INPUT_NUM   ; Get user input
    
    CLC
    ADC (STOCK_POINTER) ; Add to current stock owned
    STA (STOCK_POINTER)
    
    SEC
    SBC TOTAL       ; Subtract total cost from balance
    STA BALANCE
    
    JSR DISPLAY_BALANCE
    
    JMP MENU        ; Return to menu
    
SELL_STOCK:
    LDA (STOCK_POINTER) ; Load stock owned
    BEQ NO_STOCK      ; If user has no stock owned
    
    LDA #STOCK_PRICE   ; Load stock price
    STA TOTAL_PRICE
    
    JSR PRINT_TEXT     ; Display sell stock text
    
    JSR INPUT_NUM      ; Get user input
    
    CMP (STOCK_POINTER) ; Check if user has enough stock to sell
    BCC NOT_ENOUGH_STOCK
    
    CLC
    SBC (STOCK_POINTER) ; Subtract sold stock from stock owned
    STA (STOCK_POINTER)
    
    SEC
    ADC TOTAL_PRICE     ; Add total price to balance
    STA BALANCE
    
    JSR DISPLAY_BALANCE
    
    JMP MENU             ; Return to menu
    
NO_STOCK:
    LDA #<NO_STOCK_TEXT ; Load no stock text
    STA TEXT_POINTER
    LDA #>NO_STOCK_TEXT
    STA TEXT_POINTER+1
    
    JSR PRINT_TEXT      ; Display no stock text
    
    JMP MENU            ; Return to menu

NOT_ENOUGH_STOCK:
    LDA #<NOT_ENOUGH_TEXT ; Load not enough stock text
    STA TEXT_POINTER
    LDA #>NOT_ENOUGH_TEXT
    STA TEXT_POINTER+1
    
    JSR PRINT_TEXT      ; Display not enough stock text
    
    JMP MENU            ; Return to menu

PRINT_TEXT:
    LDX #0
PRINT_LOOP:
    LDA (TEXT_POINTER),X   ; Load text character at pointer
    BEQ PRINT_DONE         ; If end of text, exit
    JSR OUTPUT_CHAR        ; Print character
    INX
    BNE PRINT_LOOP
    
PRINT_DONE:
    RTS

INPUT_CHAR:
    JSR INPUT_WAIT  ; Wait for user input
    LDA INPUT_POS   ; Load current input position
    LDX #0
    STA (INPUT,X)
    INY
    STA INPUT_POS   ; Increment input position
    RTS

INPUT_NUM:
    LDA #0          ; Clear input variable
    STA NUM
    
NUM_LOOP:
    JSR INPUT_WAIT  ; Wait for user input
    CMP #'0'
    BCC NUM_LOOP     ; Check if input is a number
    
    CMP #'9'
    BCS NUM_LOOP
    
    CLC
    ADC #16         ; Convert ASCII to decimal
    TAX
    LDA NUM
    ASL
    ASL
    ASL
    ASL
    CLC
    ADC TAX
    STA NUM
    JMP NUM_LOOP
    
INPUT_WAIT:
    LDA #$FF
    STA WAIT
    
WAIT_LOOP:
    LDA WAIT
    BEQ WAIT_LOOP
    
    RTS

OUTPUT_CHAR:
    LDY #2
    LDA $FF00,Y ; Output character to screen
    STA $FF02
    RTS
    
DISPLAY_BALANCE:
    LDA #BALANCE_TEXT ; Load balance text
    JSR PRINT_TEXT    ; Display balance text
    
    LDA #0DEADBEEF    ; Display user balance
    JSR OUTPUT_CHAR
    LDA BALANCE
    JSR OUTPUT_CHAR
    
    RTS

MENU_TEXT: .asciiz "1. Buy Stock\n2. Sell Stock\n"
NO_STOCK_TEXT: .asciiz "You don't have any stock\n"
NOT_ENOUGH_TEXT: .asciiz "You don't have enough stock to sell\n"
STOCK_PRICE: $10
STOCK_OWNED: $20
BALANCE: $100
TOTAL: $40
TOTAL_PRICE: $50
TEXT_POINTER: $60
INPUT: $70
INPUT_POS: $80
NUM: $90

JMP START
