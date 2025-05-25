
; Program to perform basic operations on a linked list

        .org $600
start:
        lda #$00        ; Initialize the accumulator to 0
        sta list_ptr    ; Initialize list_ptr to 0
        lda #3          ; Create node with value 3
        jsr add_node    ; Call subroutine to add node
        lda #5          ; Create node with value 5
        jsr add_node    ; Call subroutine to add node
        lda #7          ; Create node with value 7
        jsr add_node    ; Call subroutine to add node
        jsr print_list  ; Print the linked list

loop:
        jmp loop

; Subroutine to add a new node to the linked list
add_node:
        lda list_ptr      ; Load list_ptr into the accumulator
        sta temp_ptr      ; Store list_ptr in temp_ptr
        lda #0            ; Load 0 into the accumulator
        sta list_ptr      ; Reset list_ptr to 0

next_node:
        lda temp_ptr      ; Load temp_ptr into the accumulator
        cmp #0            ; Compare temp_ptr with 0
        beq set_list_ptr  ; If temp_ptr is 0, set list_ptr to current node
        lda temp_ptr
        ldy #1
        clc
        adc #2            ; Calculate the address of the next node
        sta temp_ptr
        lda temp_ptr+1
        adc #0
        sta temp_ptr+1
        jmp next_node

set_list_ptr:
        lda new_node+1    ; Load the address of the new node
        sta temp_ptr
        lda new_node      ; Load the new node value
        sta (temp_ptr),y  ; Store the new node value in memory
        lda new_node+1
        sta list_ptr      ; Set the list_ptr to the address of the new node
        rts

; Subroutine to print the linked list
print_list:
        lda #$00          ; Initialize the accumulator
        sta temp_ptr      ; Initialize temp_ptr to 0

print_loop:
        lda temp_ptr      ; Load temp_ptr into the accumulator
        cmp #0            ; Compare temp_ptr with 0
        beq end_print     ; If temp_ptr is 0, end print loop
        lda (temp_ptr),y  ; Load the value of the current node
        jsr print_value   ; Print the value of the current node
        lda temp_ptr
        ldy #1
        clc
        adc #2            ; Calculate the address of the next node
        sta temp_ptr
        lda temp_ptr+1
        adc #0
        sta temp_ptr+1
        jmp print_loop

end_print:
        rts

; Subroutine to print a node value
print_value:
        ; Implement printing of value here (e.g. using BRK for test)
        brk
        rts

; Data section
list_ptr: .word $0000  ; Pointer to the head of the linked list
temp_ptr: .word $0000  ; Temporary pointer for traversal
new_node: .word $0000  ; New node to be added to the linked list
