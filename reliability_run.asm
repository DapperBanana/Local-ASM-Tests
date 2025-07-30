
; Program to calculate the sum of the first n natural numbers
; Input: n (in A register)
; Output: Sum of the first n natural numbers (in X register)

        .org $0200 ; Start address

start   LDA #0      ; Initialize sum to 0
        STA sum

        LDY #1      ; Initialize counter to 1
loop    CMPA #0     
        BEQ done    ; Exit loop if n equals 0

        CLC
        ADC counter ; Add counter to sum
        STA sum

        INY         ; Increment counter
        DECA        ; Decrement n
        BNE loop    ; Repeat loop if n is not 0

done    LDX sum     ; Load sum into X register

        ; End of program
        BRK

counter .BYTE 0
sum     .BYTE 0

        .org $FFFC ; Reset vector
        .WORD start
