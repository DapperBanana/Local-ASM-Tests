
        .org $0200

start   lda #10        ; n = 10 (change this to your desired value)
        sta n

        lda #0         ; sum = 0
        sta sum

loop    clc
        lda n          ; load n into A
        cmp #0         ; check if n is 0
        beq end        ; if n is 0, jump to end

        adc sum        ; add n to sum
        sta sum        ; store the updated sum
        dec n          ; decrement n
        jmp loop       ; repeat loop

end     ; code to display the sum goes here

n       .byte 0
sum     .byte 0
        
        .end 
