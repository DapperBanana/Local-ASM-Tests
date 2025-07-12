
    .org $0200  ; starting address
start:
    ldx #5      ; we want to calculate the sum of the first 5 natural numbers
    lda #0      ; initialize sum to 0
    sta sum
    
sum_loop:
    clc         ; clear carry flag
    lda sum     ; load current sum
    adc x       ; add current number to sum
    sta sum     ; store the result back to sum
    
    dex         ; decrement x
    bne sum_loop ; if x is not zero, loop back to sum_loop
    
    ; sum is now calculated and stored in sum
    ; you can use it for further calculations or display
    
    ; add your code here to display the sum or use it for other purposes
    
    rts         ; return from subroutine
    
sum: .byte 0     ; reserve one byte for sum variable
