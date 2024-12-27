
; Merge two sorted lists into a single sorted list
; Assume lists are in memory at locations list1 and list2
; Result will be stored in memory at location result

        .org $2000  ; Start address for program

list1   .byte $01, $03, $05, $07, $09
list2   .byte $02, $04, $06, $08, $10
result  .ds   10   ; Reserve space for merged list

start   lda #0      ; Initialize index for list1
        sta index1

merge   lda index1  ; Load index for list1
        clc
        adc #list1
        tax          ; Store effective address of element from list1 in X
        txa
        sta temp     ; Store effective address in temp
        lda (temp),y ; Load element from list1 into A
        sta elem1

        lda index2  ; Load index for list2
        clc
        adc #list2
        tax          ; Store effective address of element from list2 in X
        txa
        sta temp
        lda (temp),y ; Load element from list2 into A
        sta elem2

        cmp elem1, elem2 ; Compare elements from list1 and list2
        bcc add_elem1    ; If elem1 is less than elem2, add elem1 to result
        bcs add_elem2    ; If elem2 is less than or equal to elem1, add elem2 to result

add_elem1
        lda elem1  ; Load elem1 into A
        sta (result),y ; Store elem1 into result
        inc index1 ; Increment index for list1
        jmp next_elem ; Jump to next element comparison

add_elem2
        lda elem2  ; Load elem2 into A
        sta (result),y ; Store elem2 into result
        inc index2 ; Increment index for list2
        jmp next_elem ; Jump to next element comparison

next_elem
        inc result ; Move to next position in result
        lda index1
        cmp #5      ; Check if all elements from list1 processed
        beq list2_done ; If yes, jump to finish processing list2
        lda index2
        cmp #5      ; Check if all elements from list2 processed
        beq list1_done ; If yes, jump to finish processing list1

        jmp merge  ; Continue merging next elements

list1_done
        lda elem2  ; Load last element from list2 into A
        sta (result),y ; Store last element into result
        rts         ; Return from subroutine

list2_done
        lda elem1  ; Load last element from list1 into A
        sta (result),y ; Store last element into result
        rts         ; Return from subroutine

index1  .byte 0   ; Index for list1
index2  .byte 0   ; Index for list2
elem1   .byte 0   ; Element from list1
elem2   .byte 0   ; Element from list2
temp    .byte 0   ; Temporary storage

        .end
