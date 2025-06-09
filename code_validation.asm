
        .org $1000

        ; Constants
INV_SIZE = 10

        ; Variables
inv             .dsb INV_SIZE

        ; Program entry point
        .org $2000
start:
        ; Initialize variables
        ldx #0
        ldy #0

        ; Main program loop
mainloop:
        ; Display menu
        jsr displayMenu

        ; Get user input
        jsr getInput

        ; Branch based on user input
        cmp #1
        beq add
        cmp #2
        beq remove
        cmp #3
        beq display
        cmp #4
        beq exit

        ; Invalid input, loop back to menu
        jmp mainloop

        ; Add item to inventory
add:
        jsr clearScreen
        lda inv,x
        beq full
        inx
        bne add

addloop:
        jsr clearScreen
        ldx #0
        lda #"Enter item name: "
        jsr printString
        jsr getInput

        sta inv,x
        inx
        lda inv,x
        cmp #0
        bne addloop

        rts

        ; Remove item from inventory
remove:
        jsr clearScreen
        ldx #0
        lda inv,x
        beq empty
        jsr clearScreen
remloop:
        lda inv,y
        beq end
        dex
        jsr printString
        inx
        iny
        lda inv,x
        cpy #10
        bne remloop
        iny

end:
        ldx #0
        lda #"Enter item to remove (1-3): "
        jsr printString
        jsr getInput
        dex
        lda inv,x
        beq nothing
        lda #0
        sta inv,x

        rts

        ; Display inventory
display:
        jsr clearScreen
        ldx #0
disloop:
        lda inv,x
        beq enddis
        jsr printString
        inx
        iny
        lda inv,x
        cpy #10
        bne disloop
        iny

enddis:
        jsr getInput
        rts

        ; Exit program
exit:
        rts

        ; Display full inventory message
full:
        jsr printString
        lda #"Inventory is full."
        jsr printString
        rts

        ; Display empty inventory message
empty:
        jsr printString
        lda #"Inventory is empty."
        jsr printString
        rts

        ; Display nothing message
nothing:
        jsr printString
        lda #"Item not found."
        jsr printString
        rts

        ; Display menu
displayMenu:
        jsr clearScreen
        lda #"1. Add Item"
        jsr printString
        lda #"2. Remove Item"
        jsr printString
        lda #"3. Display Inventory"
        jsr printString
        lda #"4. Exit"
        jsr printString
        rts

        ; Get user input
getInput:
        lda #0
        sta $0300
        jsr $FFCF
        lda $0300
        rts

        ; Clear screen
clearScreen:
        lda #147
        jsr $FFD2
        rts

        ; Print null-terminated string
printString:
loop:
        lda ,x
        beq endstring
        jsr $FFD2
        inx
        jmp loop
endstring:
        rts

        .org $FFFA
        .dw start
