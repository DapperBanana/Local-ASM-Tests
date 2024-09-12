
; Program to find the sum of all elements in a list

        .org    $1000
start:
        ldx     #0             ; Initialize sum to zero
        ldy     #length        ; Load the length of the list
        lda     #0             ; Initialize index to zero
loop:   
        lda     list, y        ; Load the element at index Y
        clc                    ; Clear the carry flag
        adc     x              ; Add the element to the sum
        sta     x              ; Store the updated sum
        dey                    ; Decrement the index
        bpl     loop           ; Loop until all elements are processed
        brk

        .org    $2000
list:   .byte   $05, $03, $02, $07, $08, $FF, $0A, $20
length: .byte   8

        .end
