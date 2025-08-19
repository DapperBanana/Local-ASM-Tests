
    .org $2000
node_size = 2
data_offset = 0 ; offset of the data value in a node
next_offset = 1 ; offset of the next pointer in a node

    ; Initialize the linked list
    lda #0
    sta head_ptr
    lda #0
    sta tail_ptr

    ; Add a new node to the list
add_node:
    lda #$12 ; data value for the new node
    sta new_node, x
    lda #0
    sta temp
    lda tail_ptr
    beq first_node
    sta (temp), y
first_node:
    lda new_node
    sta head_ptr
    lda tail_ptr
    sta tail_ptr
    rts

    ; Delete a node from the list
delete_node:
    lda #0
    sta temp
    lda head_ptr
    beq empty_list
    lda (temp), y
    sta head_ptr
    rts

    ; Traverse the list and print out values
traverse_list:
    lda head_ptr
    beq done
    lda (temp), y
    ; Print out the value
    jsr print_value
    lda (temp + next_offset), y
    sta temp
    jmp traverse_list

empty_list:
    ; Handle empty list condition
    rts

done:
    rts

print_value:
    ; Implement a subroutine to print out the value
    rts

head_ptr: .res 1
tail_ptr: .res 1
new_node: .res node_size
temp: .res 1
