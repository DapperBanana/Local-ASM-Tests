
        .org $0200

start   ldx #0              ; Initialize index
        lda #$00            ; Initialize smallest value
        sta smallest
        ldy #0              ; Initialize counter

        lda list,x         ; Load first number from list
        sta largest         ; Set it as the largest value
        lda list,x
        sta smallest        ; Set it as the smallest value
        inx                 ; Increment index

loop    lda list,x         ; Load next number from list
        cmp smallest       ; Compare with smallest value
        bcc update_small   ; Update smallest value if smaller
        cmp largest        ; Compare with largest value
        bcs update_large    ; Update largest value if larger

update_small
        sta smallest        ; Update smallest value
        bra next           ; Go to next iteration

update_large
        sta largest         ; Update largest value

next    inx                 ; Increment index
        iny                 ; Increment counter
        cpx #num_values     ; Check end of list
        bne loop            ; If not end of list, continue loop

        lda num_values      ; Load number of values
        lsr                 ; Divide by 2
        lsr
        bcc odd             ; If number of values is odd, jump to odd

even    lda list             ; Load first number
        clc
        adc largest          ; Add largest
        lsr                  ; Divide by 2
        sta median           ; Store median
        bra done             ; Done

odd     lda smallest         ; Load smallest number
        clc
        adc largest          ; Add largest
        ror
        sta median           ; Store median
        bra done             ; Done

done    rts

list    .byte 4, 7, 2, 9, 5, 1, 8, 3, 6  ; List of numbers
num_values .byte 9                       ; Number of values
largest .byte 0                          ; Largest number 
smallest .byte 0                         ; Smallest number
median .byte 0                           ; Median

        .end
