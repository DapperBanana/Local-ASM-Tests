
; Binary search on 6502 Assembly

; Define constants
MAX_DATA    = $0A    ; Maximum number of elements in the list
DATA_START  = $10    ; Start address of the list
TARGET      = $20    ; Target value to search for

        ORG     $1000

START   LDX     #MAX_DATA      ; Load number of elements
        LDY     #DATA_START    ; Load start address of list
        LDY     #0              ; Initialize index to 0

SEARCH_LOOP
        LDA     (Y),X          ; Load current element
        CMP     #TARGET         ; Compare with target value
        BEQ     FOUND           ; Branch if equal

        CMP     #TARGET         ; Compare with target value
        BCS     END_SEARCH_LOOP ; Branch if current element is greater than target

        INY                     ; Increment index
        CPY     #MAX_DATA       ; Compare with maximum number of elements
        BCC     SEARCH_LOOP      ; Branch if not end of list

        BRA     NOT_FOUND       ; Branch if target value not found

FOUND   STA     $30            ; Store the index of the target value here

NOT_FOUND
        ; Target value not found

END_SEARCH_LOOP
        RTS

; Define list of sorted elements
        .byte   1, 2, 3, 4, 5, 6, 7, 8, 9, 10

        .END
