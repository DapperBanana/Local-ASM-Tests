
; Merge two sorted lists into a single sorted list

        .org $0200   ; start address

start:
        lda #<list1   ; load the low byte of the address of list1 into the accumulator
        sta ptr1      ; store the low byte of the address of list1 into ptr1
        lda #>list1   ; load the high byte of the address of list1 into the accumulator
        sta ptr1+1    ; store the high byte of the address of list1 into ptr1+1

        lda #<list2   ; load the low byte of the address of list2 into the accumulator
        sta ptr2      ; store the low byte of the address of list2 into ptr2
        lda #>list2   ; load the high byte of the address of list2 into the accumulator
        sta ptr2+1    ; store the high byte of the address of list2 into ptr2+1

        ldx #0        ; initialize index x to 0
        ldy #0        ; initialize index y to 0

merge_loop:
        lda (ptr1),y  ; load the byte at address (list1 + y) into the accumulator
        sta temp      ; store the byte in temp

        lda (ptr2),y  ; load the byte at address (list2 + y) into the accumulator
        cmp temp      ; compare the byte with temp
        bcc merge_list1 ; branch to merge_list1 if the byte from list2 is less than temp

        ; merge_list2:
        sta (ptr_out),x ; store the byte from list2 at the output list address
        iny           ; increment y
        inx           ; increment x
        cpy #list_size ; compare y with the list size
        bne merge_loop ; branch back to merge_loop if y is not equal to list_size

        rts           ; return from subroutine

merge_list1:
        sta (ptr_out),x ; store the byte from list1 at the output list address
        inx
        cpx #list_size ; compare x with the list size
        bne merge_loop ; branch back to merge_loop if x is not equal to list_size

        lda ptr2      ; load the address of list2 into the accumulator
        clc           ; clear carry flag
        adc #list_size ; add list size to the address of list2
        sta ptr_out   ; store the updated address into ptr_out

        rts           ; return from subroutine

ptr1:   .word 0        ; pointer for list1
ptr2:   .word 0        ; pointer for list2
ptr_out: .word $0400   ; output list address
temp:   .byte 0        ; temporary storage

list1:  .byte 1, 3, 5, 7, 9
list2:  .byte 2, 4, 6, 8, 10
list_size = * - list1
