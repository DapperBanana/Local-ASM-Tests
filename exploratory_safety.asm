
        .org $0200

start   lda $2001              ; Load the number of elements into A
        clc
        ldx #0                 ; Initialize X to zero for accumulating sum
        ldy #0                 ; Initialize Y to zero for counting elements
loop    lda $2000, y           ; Load the element at address $2000 + Y
        clc
        adc x                  ; Add the element to the sum in X
        iny                    ; Increment Y
        bne loop               ; Loop until Y reaches the number of elements
        lda $2001              ; Load the number of elements again
        sec
        sbc #0
        sta $2002              ; Store the number of elements in $2002
        lsr
        lsr
        lsr                    ; Divide the sum by the number of elements
        tax                    ; Store the result in X
        sta $2003              ; Store the result in $2003
        sty $2004              ; Store the number of elements in $2004

done    brk                     ; End program

        .org $2000
list    .byte 5, 10, 15, 20, 25 ; List of elements
num     .byte 5                 ; Number of elements
result  .byte 0                 ; Result (average)
count   .byte 0                 ; Number of elements (for calculating average)
