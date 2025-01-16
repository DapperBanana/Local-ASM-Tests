
; Program to calculate the sum of all even Fibonacci numbers up to a given limit

        .org $0200   ; Start address for code
start   lda #0       ; Initialize variables
        sta sum
        lda #1
        sta fib1
        lda #1
        sta fib2
        lda #0
        sta temp

loop    lda fib1      ; Calculate next Fibonacci number
        clc
        adc fib2
        sta temp
        lda fib2
        sta fib1
        lda temp
        sta fib2

        lda fib2      ; Check for even Fibonacci number
        and #1
        beq skip

        lda sum       ; Add even Fibonacci number to sum
        clc
        adc fib2
        sta sum

skip    cmp #$FFFF    ; Check if reached the given limit
        beq done

        jmp loop      ; Repeat loop

done    lda sum       ; Display the sum of even Fibonacci numbers
        sta $FFFE

        rts           ; End of program
