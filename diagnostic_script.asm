
; Inventory Management System

; Define memory addresses for variables
STOCK_START = $1000
STOCK_SIZE = 10

TOTAL_STOCK = $2000

CURR_ITEM = $3000
CURR_QTY = $3001

; Start of program
START:
    LDA #STOCK_START
    STA CURR_ITEM

LOOP:
    ; Print menu options
    JSR PRINT_MENU
    
    ; Read user input
    JSR GET_INPUT
    
    ; Check user input
    CMP #1
    BEQ ADD_ITEM
    CMP #2
    BEQ REMOVE_ITEM
    CMP #3
    BEQ DISPLAY_STOCK
    CMP #4
    BEQ EXIT
    
    ; Invalid input, try again
    JMP LOOP

ADD_ITEM:
    LDA CURR_ITEM
    CLC
    ADC #1
    CMP #STOCK_START + STOCK_SIZE
    BCS LOOP ; Stock is full, go back to main menu
    
    STA CURR_ITEM
    
    LDA CURR_ITEM
    TAX ; Copy item index to X
    
    LDA #CURR_QTY
    STA TOTAL_STOCK,X ; Save current item quantity in total stock array
    
    JSR LOOP

REMOVE_ITEM:
    LDA CURR_ITEM
    CLC
    ADC #1
    CMP #STOCK_START + STOCK_SIZE
    BCS LOOP ; Stock is full, go back to main menu
    
    STA CURR_ITEM
    
    LDA CURR_ITEM
    TAX ; Copy item index to X
    
    LDA #0
    STA TOTAL_STOCK,X ; Remove item from total stock array
    
    JSR LOOP

DISPLAY_STOCK:
    LDA #0
    STA $FC ; Print a newline
    LDA CURR_ITEM
    TAX ; Copy item index to X
    
    LDA TOTAL_STOCK,X
    JSR PRINT_VALUE
    
    JMP LOOP

EXIT:
    RTS

; Subroutine to print menu options
PRINT_MENU:
    LDA #"1. Add Item"
    JSR PRINT_STRING
    LDA $FC ; Print a newline
    LDA #"2. Remove Item"
    JSR PRINT_STRING
    LDA $FC ; Print a newline
    LDA #"3. Display Stock"
    JSR PRINT_STRING
    LDA $FC ; Print a newline
    LDA #"4. Exit"
    JSR PRINT_STRING
    LDA $FC ; Print a newline
    RTS

; Subroutine to get user input
GET_INPUT:
    LDA #"Enter option: "
    JSR PRINT_STRING
    LDA $FC ; Print a newline
    LDA $FC ; Read user input
    CMP #"1"
    BCC GET_INPUT
    CMP #"4"
    BCS GET_INPUT
    RTS

; Subroutine to print a string
PRINT_STRING:
    STA $FB ; Save string pointer
LOOP_PRINT:
    LDA $FB
    CMP #0 ; Check for null terminator
    BEQ END_PRINT
    LDY #0 ; Set Y to 0
    LDA ($FB),Y ; Load character from address stored in $FB
    JSR $FFD2 ; Print character
    INY ; Increment Y
    INY ; Increment Y (skip high byte of address)
    STY $FB ; Store incremented Y back to $FB
    JMP LOOP_PRINT
END_PRINT:
    RTS

; Subroutine to print a value
PRINT_VALUE:
    STA $FA ; Save value to be printed
    LDX #0
LOOP_VALUE:
    LDA $FA
    CMP #0 ; Check for null terminator
    BEQ END_VALUE
    LSR ; Shift value right
    TRB $FA ; Clear shifted bit
    INX ; Increment X
    JMP LOOP_VALUE
END_VALUE:
    LDA $FA
    ORA #48 ; Convert value to ASCII
    JSR $FFD2 ; Print character
    RTS

.END START
