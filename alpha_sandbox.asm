
INVENTORY_START = $0200
MAX_ITEMS = 10

.org $0200

; Initialize inventory
LDA #INVENTORY_START
LDX #MAX_ITEMS
INIT_LOOP:
STA INVENTORY_START, X
DEX
BPL INIT_LOOP

; Main program loop
MAIN_LOOP:
lda #$00    ; Display options menu
sta $FE     ; Store option in memory
lda option_selected ; Load selected option
cmp #'A'    ; Check if option is 'A'
beq add_item    ; If 'A', go to add item function
cmp #'R'    ; Check if option is 'R'
beq remove_item ; If 'R', go to remove item function
jmp MAIN_LOOP   ; Otherwise, loop back to main menu

add_item:
lda #10      ; Load item value
sta $FF      ; Store item value in memory
ldy $FE      ; Load selected option
iny       ; Increment item count
sty $FE      ; Store item count in memory
sta INVENTORY_START, Y  ; Add item to inventory
jmp MAIN_LOOP

remove_item:
lda $FE      ; Load selected option
iny       ; Decrement item count
sty $FE      ; Store item count in memory
sta INVENTORY_START, Y  ; Remove item from inventory
jmp MAIN_LOOP

.option_selected
.byte 'A'

.end
