
.INCLUDE "6502.h"
    .ORG $0200

start
    LDX #$00        ; Initialize index for inventory
    JSR clearScreen ; Clear the screen

menu:
    LDA #<messageMenu   ; Load low byte of messageMenu address
    LDY #>messageMenu   ; Load high byte of messageMenu address
    JMP printMessage    ; Jump to printMessage subroutine

getNextInput:
    LDA #<messageInput  ; Load low byte of messageInput address
    LDY #>messageInput  ; Load high byte of messageInput address
    JMP printMessage    ; Jump to printMessage subroutine

    JSR readInput       ; Read user input
    STA $FF            ; Save input to temporary memory

    LDA $FF            ; Load input back
    CMP #"a"           ; Check if option is 'a' (add)
    BEQ addInventory   ; Branch to addInventory if true
    CMP #"r"           ; Check if option is 'r' (remove)
    BEQ removeInventory ; Branch to removeInventory if true
    CMP #"v"           ; Check if option is 'v' (view)
    BEQ viewInventory   ; Branch to viewInventory if true
    CMP #"q"           ; Check if option is 'q' (quit)
    BEQ quitProgram    ; Branch to quitProgram if true
    JMP clearInput     ; Jump back to clearInput if input does not match any option

addInventory:
    JSR getNextInput    ; Get item name
    STA inventoryItems,X ; Store item name in inventoryItems array

    JSR getNextInput    ; Get item quantity
    STA inventoryQuantities,X ; Store item quantity in inventoryQuantities array

    INX                 ; Increment index
    JMP menu            ; Jump back to menu

removeInventory:
    LDA #<messageRemove ; Load low byte of messageRemove address
    LDY #>messageRemove ; Load high byte of messageRemove address
    JMP printMessage     ; Jump to printMessage subroutine

    JSR getNextInput    ; Get item to remove
    STA $FF             ; Save input to temporary memory

    LDX #$00            ; Initialize to 0
searchItem:
    LDA inventoryItems,X ; Load item name at index X
    CMP $FF             ; Compare item name with user input
    BEQ removeItem      ; Branch to removeItem if true
    INX                 ; Increment index
    CPX #inventoryLength ; Check if end of inventory
    BNE searchItem      ; Branch back to searchItem if not at end

    LDA #<messageNotFound ; Load low byte of messageNotFound address
    LDY #>messageNotFound ; Load high byte of messageNotFound address
    JMP printMessage       ; Jump to printMessage subroutine
    JMP menu              ; Jump back to menu

removeItem:
    LDX #$00            ; Initialize to 0
moveItems:
    LDA inventoryItems,X ; Load item name at index X
    CMP $FF             ; Compare item name with user input
    BEQ shiftItem       ; Branch to shiftItem if true

    INX                 ; Increment index
    CPX #inventoryLength ; Check if end of inventory
    BNE moveItems       ; Loop back if not at end

    JMP menu            ; Jump back to menu

shiftItem:
    LDX #$00            ; Initialize to 0
shiftItems:
    LDA inventoryItems,X ; Load item name at index X
    STA inventoryItems-1,X ; Move item name to previous index

    INX                 ; Increment index
    CPX #inventoryItemsLength  ; Check if end of inventory
    BNE shiftItems      ; Loop back if not at end

    DEC inventoryItemsLength   ; Decrease inventory length

    LDX #$00            ; Initialize to 0
shiftQuantities:
    LDA inventoryQuantities,X ; Load item quantity at index X
    STA inventoryQuantities-1,X ; Move item quantity to previous index

    INX                 ; Increment index
    CPX #inventoryQuantitiesLength ; Check if end of inventory quantities
    BNE shiftQuantities ; Loop back if not at end

    DEC inventoryQuantititiesLength ; Decrease inventory quantities length

    JMP menu            ; Jump back to menu

viewInventory:
    LDX #$00            ; Initialize index for loop
    LDA #<messageInventory  ; Load low byte of messageInventory address
    LDY #>messageInventory  ; Load high byte of messageInventory address
    JSR printMessage    ; Print inventory header

    LDX #$00            ; Reinitialize index for loop
printItems:
    LDA inventoryItems,X ; Load item name at index X
    JSR printString     ; Print item name
    JSR printSpace      ; Add a space
    LDA inventoryQuantities,X ; Load item quantity at index X
    JSR printNumber     ; Print item quantity
    JSR printNewLine    ; Move to next line

    INX                 ; Increment index
    CPX #inventoryItemsLength ; Check if end of inventory
    BNE printItems      ; Loop back if not at end

    JMP menu            ; Jump back to menu

quitProgram:
    JMP $FFFF           ; End program

clearInput:
    LDX $FF
    LDA #0
    STA inventoryItems,X
    STA inventoryQuantities,X
    INX
    CPX #inventoryLength
    BNE clearInput

    JMP menu

printMessage:
    JSR clearInput      ; Clear previous input
    LDA (Y,X)           ; Load message into A
printLoop:
    CMP #0              ; Check for end of message
    BEQ printEnd        ; If end of message, finish
    JSR $FFD2           ; Print character
    INX                 ; Increment index
    LDA (Y,X)           ; Load next character
    JMP printLoop       ; Continue printing message
printEnd:
    RTS

printString:
    LDY #$00
printStringLoop:
    LDA (X),Y           ; Load character from string
    BEQ printStringEnd  ; If end of string, finish
    JSR $FFD2           ; Otherwise, print character
    INY                 ; Increment index
    JMP printStringLoop ; Continue printing string
printStringEnd:
    RTS

printNumber:
    JSR clearInput      ; Clear previous input
    LDA (X)             ; Load first digit of number
    JSR $FFD2           ; Print first digit
    INX                 ; Move to next digit
    LDA (X)             ; Load next digit
    BEQ printNumberEnd  ; If end of number, finish
    JMP printNumber     ; Continue printing number
printNumberEnd:
    RTS

printSpace:
    LDA #" "            ; Load space character
    JSR $FFD2           ; Print space
    RTS

printNewLine:
    LDA #<$0D00         ; Load low byte of new line character
    LDY #>$0D00         ; Load high byte of new line character
    JMP $FFD2           ; Print new line character
    RTS

clearScreen:
    LDA #<$E400         ; Load low byte of clear screen character
    LDY #>$E400         ; Load high byte of clear screen character
    JMP $FFD2           ; Clear screen
    RTS

    .BSS
messageMenu:  .BYTE "a: add item, r: remove item, v: view inventory, q: quit",0

messageInput: .BYTE "Enter option: ",0
messageRemove: .BYTE "Enter item to remove: ",0
messageNotFound: .BYTE "Item not found",0
messageInventory: .BYTE "Inventory:",0

inventoryItems:        .BLKB inventoryLength
inventoryQuantities:   .BLKB inventoryLength
inventoryItemsLength   .DA #0
inventoryQuantitiesLength .DA #0

inventoryLength: .DA 10

    .ORG $FFFA
    .WORD start
    .WORD start
    .WORD start
