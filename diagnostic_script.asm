

; Define a linked list node structure
node:
    .struct
    value       .byte
    next        .word
    .endstruct

; Define the linked list
list:
    .byte   5
    .word    0
    .byte   3
    .word    0
    .byte   8
    .word    0
    .byte   2
    .word    0
    .byte   1
    .word    0
    .byte   6
    .word    0
    .byte   4
    .word    0

start:
    ; Initialize the list pointer
    ldx  #<list
    ldy  #>list
    stx  ptr
    sty  ptr+1

    ; Print the list
    lda  #0
print_loop:
    clc
    lda  (ptr),y         ; Load value of current node
    jsr  print_value     ; Print the value
    
    lda  (ptr),y         ; Load next pointer
    beq  end_print       ; If next pointer is 0, end
    clc
    adc  #3
    tay
    lda  (ptr),y         ; Load next pointer high
    tax
    bcc  next_node       ; Branch if no carry
    iny
next_node:
    stx  ptr
    sty  ptr+1
    jmp  print_loop

end_print:

    ; Add 10 to every node in the list
    ldx  #<list
    ldy  #>list
    
add_loop:
    lda  (ptr),y         ; Load current node value
    clc
    adc  #10             ; Add 10
    sta  (ptr),y         ; Store updated value
    
    lda  (ptr),y         ; Load next pointer
    beq  end_add        ; If next pointer is 0, end
    clc
    adc  #3
    tay
    lda  (ptr),y         ; Load next pointer high
    tax
    bcc  next_node_add  ; Branch if no carry
    iny
next_node_add:
    stx  ptr
    sty  ptr+1
    jmp  add_loop

end_add:
    rts

; Subroutine to print the value
print_value:
    ; Handle positive numbers only
    cmp  #10
    bcc  print_single_digit
    lda  #10
print_single_digit:
    clc
    adc  #48
    jsr  $ffd2          ; Print character
    lda  #32            ; Print space
    jsr  $ffd2          ; Print character
    rts

ptr:    .block  2   ; Pointer to current node in the list

