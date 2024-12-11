
; Define constants
NODE_SIZE = 2          ; Size of each node in bytes
LIST_HEAD = $f0        ; Address of the head of the linked list
BUFFER = $fe           ; Buffer for input data

; Define the structure of a node in the linked list
.struct Node
    Value .byte
    Next .byte
.ends

.org $1000

main:
    sei                 ; Disable interrupts
    cld                 ; Clear decimal mode
    
    ; Initialize the linked list
    lda #$00            ; Initialize the head of the list
    sta LIST_HEAD
    ldx #$00            ; Initialize index counter
    
    ; Add nodes to the linked list
add_nodes:
    lda BUFFER, x       ; Load the next value from the buffer
    beq end_loop        ; Exit loop on zero termination
    
    ; Allocate memory for a new node
    lda LIST_HEAD       ; Load the head of the list
    clc
    adc #NODE_SIZE
    sta LIST_HEAD       ; Update the head of the list
    
    ; Create a new node with the value from the buffer
    sta Node.Value, y   ; Store the value in the new node
    lda LIST_HEAD       ; Load the address of the new node
    sta Node.Next, y    ; Store the next pointer in the new node
    
    ; Move to the next value in the buffer
    inx
    jmp add_nodes

end_loop:
    jmp print_list      ; Print the content of the linked list
    
print_list:
    lda LIST_HEAD       ; Load the head of the list
    
loop:
    lda Node.Value, y   ; Load the value from the current node
    jsr $ffd2           ; Display the value (customize this address based on your display method)
    
    lda Node.Next, y    ; Load the next pointer from the current node
    beq end_print       ; Exit loop if reached end of the list
    
    tax                 ; Save the current index
    lda Node.Next, x    ; Load the next index
    jmp loop

end_print:
    
    ; End of program
    cli                 ; Enable interrupts
    rts                 ; Return from subroutine
