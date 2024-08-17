
        .org $8000

start   lda #$00            ; Initialize sum to 0
        sta sum

        ldx #$00            ; Initialize counter to 0
        lda #$00
        sta counter

loop    lda $A000, x       ; Load the next element from the list
        clc
        adc sum            ; Add the element to the sum
        sta sum
        
        inx                ; Increment the counter
        cpx #$0A           ; Check if we have processed all elements
        bne loop

        clc
        lda sum            ; Load the sum
        ldx #$0A           ; Load the number of elements
        div counter        ; Divide the sum by the number of elements

        sta $A010          ; Store the average result in memory
        
        rts

sum     .byte $00
counter .byte $00

        .org $A000
data    .byte 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
