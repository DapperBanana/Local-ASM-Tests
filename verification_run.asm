
; Linked list node structure
.node struct
    value .byte
    next_ptr .word
.endstruct

; Linked list operations
.segment "CODE"
MAIN:
    ; Initialize linked list head pointer
    LDA #0
    STA HEAD_PTR
    LDA #<NODE1
    STA HEAD_PTR + 1

    ; Insert elements into linked list
    LDA #10
    STA NODE1.value
    LDA #<NODE2
    STA NODE1.next_ptr

    LDA #20
    STA NODE2.value
    LDA #<NODE3
    STA NODE2.next_ptr

    LDA #30
    STA NODE3.value
    LDA #0
    STA NODE3.next_ptr

    ; Traverse linked list
    LDA #0
    BIT HEAD_PTR
    BEQ END

TRAVERSE:
    LDA HEAD_PTR
    STA CURRENT_NODE
    LDA HEAD_PTR + 1
    STA CURRENT_NODE + 1

    LDA CURRENT_NODE
    JSR PRINT_NODE_VALUE

    LDA CURRENT_NODE + 1
    TAX
    BEQ END

    LDA (CURRENT_NODE),Y
    STA CURRENT_NODE
    INY
    LDA (CURRENT_NODE),Y
    STA CURRENT_NODE + 1
    JMP TRAVERSE

END:
    RTS

PRINT_NODE_VALUE:
    LDA (CURRENT_NODE), X
    JSR $FFD2 ; Output value to screen
    RTS

; Linked list nodes
.segment "DATA"
HEAD_PTR .word
NODE1 .struct
    value .byte
    next_ptr .word
.endstruct
NODE2 .struct
    value .byte
    next_ptr .word
.endstruct
NODE3 .struct
    value .byte
    next_ptr .word
.endstruct
CURRENT_NODE .word

.segment "CODE"
.include "path_to_kernal_file.asm"
