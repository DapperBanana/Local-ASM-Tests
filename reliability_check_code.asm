
        .org $0600
nums    .byte $0A, $0B, $0C, $0D  ; list of numbers (change as needed)
numCnt  .byte $04                  ; number of numbers in the list

start   lda numCnt                ; load the number of numbers
        clc
        adc #1                    ; add 1 to account for zero-based indexing
        tax                       ; store it in X register
        ldx #0                    ; initialize the index
        lda nums,x                ; load the first number
        sta result                ; set it as the initial result

loop    inx                       ; increment the index
        cpx numCnt                ; check if we have processed all numbers
        beq end                   ; if yes, exit the loop

        lda result                ; load the current result
        clc
        adc nums,x                ; add the next number from the list
        jsr calculateLCM          ; calculate the LCM
        sta result                ; store the result

        jmp loop                  ; repeat the loop

end     brk

calculateLCM
        sta tempResult            ; store the temporary result

nextMultiple
        lda tempResult            ; load the temporary result
        clc
        adc result                ; add the current result
        sta tempResult            ; store the new temporary result

        lda tempResult            ; load the new temporary result
        ldx #0                    ; initialize the index
        lda nums,x                ; load the first number from the list
        jsr calculateGCD          ; calculate the GCD
        lda nums,x                ; load the first number from the list
        clc
        adc nums,x                ; add the next number from the list
        jsr calculateLCM          ; calculate the LCM
        cmp tempResult            ; compare the new LCM with the temporary result
        bne nextMultiple          ; if not equal, continue

        rts

calculateGCD
        sta dividend
        ldx #1
        lda nums,x
        sta divisor

gcdLoop lda divisor
        beq gcdDone
        sec
        sbc dividend
        bcc gcdSwap
        tay
        lda divisor
        sta dividend
        lda y
        sta divisor
gcdSwap jmp gcdLoop

gcdDone lda dividend
        rts

result  .byte 0
tempResult .byte 0
dividend .byte 0
divisor .byte 0

        .end
