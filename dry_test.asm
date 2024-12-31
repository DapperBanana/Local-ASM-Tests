
        .org    $0200
start:
        lda     #$13    ; Load the number of elements in the list
        sta     elements

        ; Load the list of numbers into memory
        ldx     #$00    ; Initialize index for looping
load:
        lda     numbers, x
        sta     $0300, x    ; Store the number in memory starting at $0300
        inx
        cpx     elements
        bne     load

        ; Sort the list of numbers in ascending order
        ldx     #$00
outer_loop:
        ldx     elements
        dex
        beq     end_sort
inner_loop:
        lda     $0300, x
        cmp     $0300, x+1
        bcc     skip_swap
        sta     temp
        lda     $0300, x+1
        sta     $0300, x
        lda     temp
        sta     $0300, x+1
skip_swap:
        inx
        cpx     elements
        bne     inner_loop
        dex
        jmp     outer_loop
end_sort:

        ; Calculate the median
        lda     elements
        lsr     A        ; Divide the number of elements by 2
        beq     even_elements
        clc
        lda     $0300, x
        jmp     end

even_elements:
        lda     $0300, x
        clc
        adc     $0300, x+1
        ror     A        ; Divide the sum by 2

end:
        ; Store the median in memory at $0400
        sta     $0400

done:
        jmp     done    ; Loop forever

elements:    .byte    $00
temp:        .byte    $00
numbers:     .byte    $12, $05, $1B, $08, $0F, $03 ; List of numbers

        .org    $0400
median:     .byte    $00    ; Memory location to hold the median
