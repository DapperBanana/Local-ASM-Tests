
; Program to find the common elements between two lists

; Define two lists
list1 .byte 1, 5, 3, 8, 2
list2 .byte 3, 7, 5, 2, 6

; Define variables
common_elements .byte 5 ; Maximum number of common elements expected
count .byte 0 ; Counter for number of common elements found

; Start of program
        lda #0 ; Load accumulator with 0
        sta count ; Store 0 in count
        lda #<list1 ; Load least significant byte of list1 address
        sta ptr1 ; Store it in pointer 1
        lda #>list1 ; Load most significant byte of list1 address
        sta ptr1+1 ; Store it in pointer 1
loop1   ldx #0 ; Load X register with 0
        lda (ptr1),x ; Load accumulator with value at list1[X]
        lda #<list2 ; Load least significant byte of list2 address
        sta ptr2 ; Store it in pointer 2
        lda #>list2 ; Load most significant byte of list2 address
        sta ptr2+1 ; Store it in pointer 2
loop2   lda (ptr2),x ; Load accumulator with value at list2[X]
        cmp (ptr1),x ; Compare value at list1[X] with value at list2[X]
        beq found_common_element ; If equal, jump to found_common_element
        inx ; Increment X register
        cpx #5 ; Check if end of list is reached
        bne loop2 ; If not, continue looping through list2
        inx ; Increment X register
        cpx #5 ; Check if end of list is reached
        bne loop1 ; If not, continue looping through list1
done    rts ; Return from subroutine

found_common_element
        lda (ptr1),x ; Load accumulator with value at list1[X]
        sta common_elements,x ; Store the common element in common_elements array
        inc count ; Increment count of common elements found
        inx ; Increment X register
        cpx #5 ; Check if end of list is reached
        bne loop1 ; If not, continue looping through list1

        lda count ; Load count of common elements found
        sta $fb ; Store it in $FB memory location
        ldx #0 ; Load X register with 0
print_elements
        lda common_elements,x ; Load accumulator with common element
        sta $fc ; Store it in $FC memory location
        ldx $fb ; Load count of common elements found
        dex ; Decrement X register
        bpl print_elements ; Loop through and print common elements
