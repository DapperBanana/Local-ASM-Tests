
    .text
    .org $0200

; Program to find common elements between two lists

start:
    lda #10        ; Length of the lists
    sta list_length
    
    lda list1       ; Load the address of list1
    sta list_ptr1
    lda list2       ; Load the address of list2
    sta list_ptr2

loop:
    lda (list_ptr1), y   ; Load the current element of list1
    sta current_element

    ldy #0      ; Reset index y

    lda #0      ; Reset match flag
    sta match_flag

inner_loop:
    lda (list_ptr2), y   ; Load the current element of list2
    cmp current_element ; Compare elements

    beq found_match    ; If match found, jump

    iny
    cpy list_length    ; Check end of the list2
    bne inner_loop

    jmp next_element

found_match:
    lda #1     ; Set match flag
    sta match_flag

next_element:
    iny
    cpy list_length    ; Check end of the list1
    bne loop

    rts

list1:    .byte $01, $02, $03, $04, $05
list2:    .byte $03, $04, $05, $06, $07

list_ptr1: .word list1
list_ptr2: .word list2
list_length: .byte 0
current_element: .byte 0
match_flag: .byte 0
