
START:  LDA #0             ; Initialize accumulator
        STA STOCK_PRICE    ; Initial stock price
        STA BALANCE        ; Initial balance
        LDX #0             ; Initialize index register
LOOP:   LDA STOCK_PRICE    ; Load current stock price
        STA TEMP           ; Store in temporary variable

        ; Display menu
        LDA #1             ; Print menu option
        JSR PRINT
        LDA #2             ; Print menu option
        JSR PRINT
        LDA #3             ; Print menu option
        JSR PRINT
        LDA #4             ; Print menu option
        JSR PRINT

        ; Get user input
        JSR INPUT
        
        ; Process user input
        CMP #1
        BEQ BUY
        CMP #2
        BEQ SELL
        CMP #3
        BEQ SHOW_PRICE
        CMP #4
        BEQ EXIT

        ; Invalid input
        LDA #5             ; Print error message
        JSR PRINT
        JMP LOOP

BUY:    LDA BALANCE        ; Load current balance
        SEC
        SBC STOCK_PRICE   ; Subtract stock price
        BCC NOT_ENOUGH

        ; Buy stock
        LDA TEMP           ; Load current stock price
        STA STOCK_PRICE    ; Update stock price
        ADC #1             ; Increment stock count
        STA STOCK_COUNT

        LDA BALANCE        ; Load current balance
        SEC
        SBC TEMP           ; Subtract stock price
        STA BALANCE        ; Update balance

        JMP LOOP

NOT_ENOUGH:
        LDA #6             ; Print error message
        JSR PRINT
        JMP LOOP

SELL:   LDA STOCK_COUNT    ; Load current stock count
        BEQ NO_STOCK

        ; Sell stock
        LDA TEMP           ; Load current stock price
        STA TEMP2
        LDA STOCK_PRICE    ; Load stock price
        STA TEMP
        LDA BALANCE        ; Load current balance
        CLC
        ADC TEMP           ; Add stock price to balance
        STA BALANCE        ; Update balance
        LDA STOCK_COUNT    ; Load current stock count
        SEC
        SBC #1             ; Decrement stock count
        STA STOCK_COUNT
        LDA TEMP2
        STA STOCK_PRICE

        JMP LOOP

NO_STOCK:
        LDA #7             ; Print error message
        JSR PRINT
        JMP LOOP

SHOW_PRICE:
        LDA STOCK_PRICE    ; Load current stock price
        JSR PRINT
        JMP LOOP

PRINT:  STA OUTPUT         ; Store character in output buffer
        LDA #0             ; Load null terminator
        STA OUTPUT+1       ; Terminate string
        LDY #0             ; Initialize index register
PRINT_LOOP:
        LDA OUTPUT,Y       ; Load character from output buffer
        BEQ PRINT_END      ; Check for termination
        JSR $ffd2          ; KERNAL routine to print character
        INY                ; Increment index
        JMP PRINT_LOOP
PRINT_END:
        RTS

INPUT:  LDA #0             ; Initialize index register
INPUT_LOOP:
        JSR $ffcf          ; KERNAL routine to get character from keyboard
        CMP #"0"           ; Check for valid input range
        BCC INVALID_INPUT
        CMP #"4"
        BCS INVALID_INPUT
        RTS
INVALID_INPUT:
        LDA #8             ; Print error message
        JSR PRINT
        JMP INPUT_LOOP

EXIT:   RTS

STOCK_PRICE: .BYTE 0
BALANCE:     .BYTE 0
STOCK_COUNT:  .BYTE 0
OUTPUT:      .BYTE 0,0
TEMP:        .BYTE 0
TEMP2:       .BYTE 0
