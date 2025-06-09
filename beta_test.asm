
; Declare variables
.data
list_start .byte $00
node_count .byte $00

.code
; Program entry point
start:
    ; Initialize the linked list
    lda #<new_node
    sta list_start
    lda #>new_node
    sta list_start+1
    inc node_count

    ; Perform basic operations on the linked list
    jsr add_node
    jsr add_node
    jsr print_list
    jsr delete_node

    ; End of program
    rts

; Function to add a new node to the linked list
add_node:
    lda list_start
    beq add_first_node

    lda #<new_node
    sta (list_start),y
    inc node_count
    rts

add_first_node:
    lda #<new_node
    sta list_start
    lda #>new_node
    sta list_start+1
    inc node_count
    rts

; Function to print the linked list
print_list:
    lda list_start
    beq end_printing

print_node:
    lda (list_start),y
    ; Print the data byte
    jsr print_byte
    ; Print a separator, e.g. comma
    jsr print_separator
    ; Move to the next node
    jmp next_node

next_node:
    lda list_start+1
    tay
    lda (list_start),y
    beq end_printing
    jmp print_node

end_printing:
    rts

; Function to delete a node from the linked list
delete_node:
    lda list_start
    beq end_deletion

    lda #0000
    sta list_start
    sta list_start+1
    dec node_count

end_deletion:
    rts

; Helper function to print a byte in the accumulator
print_byte:
    ; Output the byte as ASCII character
    ; (Please implement this according to the specific output method used)

; Helper function to print a separator (e.g. comma)
print_separator:
    ; Output the separator as ASCII character
    ; (Please implement this according to the specific output method used)

; Define a new node in the linked list
new_node:
    .byte $FF  ; Data byte
    .byte $00  ; Pointer to the next node

