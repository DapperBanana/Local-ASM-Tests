
        .org $0600  ; start address

start   lda #10      ; set n to 10
        sta n
        
        lda #0       ; initialize sum to 0
        sta sum
        
        lda #1       ; initialize counter to 1
        sta counter
        
loop    lda counter  ; load counter into accumulator
        cmp n        ; compare counter with n
        beq done     ; if counter equals n, jump to done
        
        clc          ; clear carry flag
        adc sum      ; add counter to sum
        sta sum      ; store the updated sum
        
        inx          ; increment counter
        lda counter
        cmp n
        bne loop     ; if counter not equal to n, jump back to loop
        
done    lda sum      ; load the final sum into accumulator
        
        ; your code to output the sum goes here
        
        rts          ; return from subroutine

n       .byte 0      ; variable for n
sum     .byte 0      ; variable for sum
counter .byte 0      ; variable for counter
