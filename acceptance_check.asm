
        .org $1000

start   LDA #0         ; Initialize sum to 0
        STA sum

input   LDA #<number   ; Load least significant byte of number
        STA numLSB
        LDA #>number    ; Load most significant byte of number
        STA numMSB

        LDX #0          ; Initialize counter to 0

loop    LDA numMSB     ; Load most significant byte
        CLC
        ADC numLSB     ; Add least significant byte
        STA numMSB     ; Store result in most significant byte
        LSR             ; Divide by 2
        TAX             ; Save result in X
        BMI notSquare   ; If result is negative, number is not a perfect square
        CPX numLSB     ; Compare result with least significant byte
        BNE notSquare   ; If not equal, number is not a perfect square

        LDA sum         ; Load sum
        CLC
        ADC numLSB     ; Add least significant byte to sum
        STA sum         ; Store result in sum

notSquare
        INX             ; Increment counter
        LDA numMSB     ; Load most significant byte
        CMP #0          ; Compare with 0
        BNE loop        ; If not zero, continue loop

        LDA sum         ; Load sum
        CMP numLSB     ; Compare with least significant byte
        BNE notPerfect  ; If not equal, number is not a perfect square

isPerfect
        ; Number is a perfect square
        JMP $FFFC       ; End program

notPerfect
        ; Number is not a perfect square
        JMP $FFFC       ; End program

number  .word 144       ; Input number
numLSB  .byte 0         ; Least significant byte of number
numMSB  .byte 0         ; Most significant byte of number
sum     .word 0         ; Variable to store sum

        .end
