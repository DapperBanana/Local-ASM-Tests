
processor 6502
include "vcs.h"

.segment "CODE"
LDA #0              ; Initialize index
STX current_index
LDX #0              ; Initialize accumulator

load_element:
    LDA list, X      ; Load element from list
    STA current_value

    JSR calculate_square ; Calculate square of current element
    STA list, X          ; Store squared value back in list

    INX               ; Increment index
    CPX #7            ; Check if end of list
    BNE load_element  ; If not, load next element
    BRK               ; End program

calculate_square:
    ASL current_value   ; Multiply by itself
    TAX               ; Save result in X
    RTS

.segment "DATA"
list: .byte 5, 3, 7, 2, 4, 6, 8
current_index: .byte 0
current_value: .byte 0
