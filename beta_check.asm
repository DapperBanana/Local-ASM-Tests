
; Inventory Management System

.INCLUDE "vcs.h"

SEG.U VSERAM    ; VCS RAM segment

; Define variables
INV_START = $80 ; Start of inventory array
INV_SIZE = 10   ; Maximum number of items in inventory
INV_COUNT = $FE ; Number of items currently in inventory
ITEMS_ADDED = $FF ; Flag for added items
ITEMS_REMOVED = $100 ; Flag for removed items

; Define variables for input
INPUT_START = $110  ; Start of input buffer
INPUT_END = $11F     ; End of input buffer
INPUT_LEN = INPUT_END - INPUT_START + 1

; Define constants
MSG_ADD DB "Enter item to add: "
MSG_REMOVE DB "Enter item to remove: "
MSG_INVALID DB "Invalid input. Please try again."
MSG_FULL DB "Inventory is full. Cannot add more items."
MSG_EMPTY DB "Inventory is empty. Cannot remove more items."

ORG $F000  ; Start of program

START
    LDX #INV_START
    LDA #0
    STA INV_COUNT  ; Initialize inventory count to 0

    JSR DisplayMenu
    JSR ReadInput

    CMP ITEMS_ADDED
    BEQ AddItem

    CMP ITEMS_REMOVED
    BEQ RemoveItem

END
    BRK

DisplayMenu
    ; Display menu options
    LDA #MSG_ADD
    JSR DisplayMessage

    LDA #MSG_REMOVE
    JSR DisplayMessage

    RTS

AddItem
    LDA INV_COUNT
    CMP #INV_SIZE
    BEQ InventoryFull

    LDA #MSG_INVALID
    JSR DisplayMessage

    LDA INV_COUNT
    CLC
    ADC #1
    STA INV_COUNT
    RTS

RemoveItem
    LDA INV_COUNT
    CMP #0
    BEQ InventoryEmpty

    LDA #MSG_INVALID
    JSR DisplayMessage

    LDA INV_COUNT
    SEC
    SBC #1
    STA INV_COUNT
    RTS

InventoryFull
    LDA #MSG_FULL
    JSR DisplayMessage
    RTS

InventoryEmpty
    LDA #MSG_EMPTY
    JSR DisplayMessage
    RTS

DisplayMessage
    LDY #0
    LDA (LDA),Y
    BEQ .End
    JSR CHROUT
    INY
    JMP DisplayMessage

.End
    RTS

ReadInput
    STY INPUT_START
    LDA #INPUT_LEN
    STA $D010  ; Set input length

    LDA INPUT_START
    JSR IO_RAWIN

    ; Check for newline character and null terminate string
    LDX #0
    STX INPUT_END
    INX
    LDA INPUT_START,X
    CMP #$0D
    BEQ .End
    CMP #0
    BEQ .End
    JMP ReadInput

.End
    RTS

.INCLUDE "vcsend.asm"
