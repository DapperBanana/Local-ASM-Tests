
.INCLUDE "6502.inc"
.STRINGZ "BUY"
.STRINGZ "SELL"
.STRINGZ "EXIT"

STOCK_PRICE .BYTE 100        ; initial stock price
STOCK_AMOUNT .BYTE 0          ; initial amount of stock

; Main program loop
MAIN:
    LDA #0         ; Clear accumulator
    JSR PRINT_MENU       ; Print menu options
    JSR READ_INPUT       ; Read user input
    
    CMP #"B"       ; Compare input to 'B' (BUY)
    BEQ BUY_STOCK       ; If input is 'B', go to BUY_STOCK
    
    CMP #"S"       ; Compare input to 'S' (SELL)
    BEQ SELL_STOCK       ; If input is 'S', go to SELL_STOCK
    
    CMP #"E"       ; Compare input to 'E' (EXIT)
    BEQ EXIT_PROGRAM     ; If input is 'E', go to EXIT_PROGRAM
    
    JMP MAIN       ; Return to main loop

BUY_STOCK:
    JSR PRINT_BUY_MENU   ; Print buy menu options
    JSR READ_INPUT       ; Read user input
    
    CMP #"Y"       ; Compare input to 'Y' (YES)
    BEQ BUY_SUCCESS      ; If input is 'Y', go to BUY_SUCCESS
    
    JMP MAIN       ; Otherwise, return to main loop

BUY_SUCCESS:
    LDA STOCK_PRICE
    CLC
    ADC #1         ; Increase stock price by 1
    STA STOCK_PRICE
    
    LDA STOCK_AMOUNT
    CLC
    ADC #1         ; Increase stock amount by 1
    STA STOCK_AMOUNT
    
    JMP MAIN       ; Return to main loop

SELL_STOCK:
    JSR PRINT_SELL_MENU  ; Print sell menu options
    JSR READ_INPUT       ; Read user input
    
    CMP #"Y"       ; Compare input to 'Y' (YES)
    BEQ SELL_SUCCESS     ; If input is 'Y', go to SELL_SUCCESS
    
    JMP MAIN       ; Otherwise, return to main loop

SELL_SUCCESS:
    LDA STOCK_PRICE
    SEC
    SBC #1         ; Decrease stock price by 1
    STA STOCK_PRICE
    
    LDA STOCK_AMOUNT
    SEC
    SBC #1         ; Decrease stock amount by 1
    STA STOCK_AMOUNT
    
    JMP MAIN       ; Return to main loop

EXIT_PROGRAM:
    RTS           ; Exit program

; Print menu options
PRINT_MENU:
    LDX #0         ; Initialize index for menu options
    
PRINT_MENU_LOOP:
    LDA #0
    ASL           ; multiply the index by 2 for pointer
    LDA (MENU_TABLE, X)
    JSR PRINT_STRING
    
    INX           ; Move to next menu option
    CPX #3         ; Check if all menu options are printed
    BNE PRINT_MENU_LOOP
    
    RTS           ; Return from subroutine

; Print menu options for buying stocks
PRINT_BUY_MENU:
    LDA #0
    STA $01        ; clear ATASCII value in 6502
    
    LDA MENU_BUY
    JSR PRINT_STRING
    
    LDA #3
    JSR PRINT_MENU_OPTIONS
    
    RTS           ; Return from subroutine

; Print menu options for selling stocks
PRINT_SELL_MENU:
    LDA #0
    STA $01        ; clear ATASCII value in 6502
    
    LDA MENU_SELL
    JSR PRINT_STRING
    
    LDA #3
    JSR PRINT_MENU_OPTIONS
    
    RTS           ; Return from subroutine

READ_INPUT:
    LDA #0
    STA $01        ; clear ATASCII value in 6502
    
    LDA #0
    STA $02        ; initialize GETCHR counter
    JSR GETCHR       ; Get user input
    
    RTS           ; Return from subroutine

PRINT_STRING:
    LDA #$21       ; Print ATASCII string
    JSR CHROUT
    
    LDA ($01),Y      ; Print string character
    CMP #0
    BEQ END_PRINT_STR
    
    JSR CHROUT       ; Print character
    INY           ; Move to next character
    JMP PRINT_STRING     ; Repeat until end of string
    
END_PRINT_STR:
    RTS           ; Return from subroutine

.MACRO PRINT_MENU_OPTIONS
    LDX #0         ; Initialize index for menu options
    
PRINT_MENU_OPTIONS_LOOP:
    LDA #0
    ASL           ; multiply the index by 2 for pointer
    LDA (MENU_OPTIONS_TABLE, X)
    JSR PRINT_STRING
    
    INX           ; Move to next menu option
    CPX #3         ; Check if all menu options are printed
    BNE PRINT_MENU_OPTIONS_LOOP
    
    RTS           ; Return from subroutine
.ENDM

MENU_TABLE:
.BYTE MENU_BUY - MENU_TABLE
.BYTE MENU_SELL - MENU_TABLE
.BYTE MENU_EXIT - MENU_TABLE

MENU_OPTIONS_TABLE:
.BYTE MENU_YES - MENU_OPTIONS_TABLE
.BYTE MENU_NO - MENU_OPTIONS_TABLE

MENU_BUY:
.STRINGZ "Do you want to buy a stock? (Y/N)"
MENU_SELL:
.STRINGZ "Do you want to sell a stock? (Y/N)"
MENU_EXIT:
.STRINGZ "Exit program"

MENU_YES:
.STRINGZ "Yes"
MENU_NO:
.STRINGZ "No"

.GETCHR_PRI $FF      ; primary GETCHR   $FF

    .ORG $300       ; start program at memory location $300
    SEI           ; Disable irq
    CLD           ; Clear decimal mode
    LDA #$D0       ; Value for 6532
    STA $C000          ; set new 6532 vector
    LDA #$03       ; Set up IRQ for the kernel device
    STA $FFFE
    LDA #<"INIT_K"       ; VECTOR LOW BYTE (X:INIT_K)
    STA $FFFF
    LDA #>"INIT_K"       ; VECTOR HIGH BYTE
    STA $FFFF + 1

INIT:
    .WORD MAIN

    RTS           ; end

    ; Initial values for stock price and amount
.INIT: 
    LDA #100       ; Stock price = $100
    STA STOCK_PRICE
    LDA #0         ; Stock amount = 0
    STA STOCK_AMOUNT

    RTS           ; end
