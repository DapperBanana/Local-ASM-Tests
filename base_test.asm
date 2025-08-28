
        .org    $1000

start:
        lda     #0              ; Initialize sum to zero
        sta     sum

        lda     #1              ; Initialize Fibonacci sequence
        sta     fib1
        
        lda     #1
        sta     fib2

        lda     #0              ; Initialize counter
        sta     counter

loop:   
        lda     fib2            ; Calculate next Fibonacci number
        clc
        adc     fib1
        sta     temp
        lda     fib2
        sta     fib1
        lda     temp
        sta     fib2

        lda     temp
        and     #$01            ; Check if Fibonacci number is even
        beq     not_even

        lda     sum             ; Add even Fibonacci number to sum
        clc
        adc     temp
        sta     sum

not_even:
        lda     temp
        cmp     limit           ; Check if reached the limit
        beq     done

        inc     counter         ; Increment counter
        jmp     loop

done:
        rts

limit:
        .byte   13              ; Limit of Fibonacci sequence

sum:
        .byte   0               ; Sum of even Fibonacci numbers

fib1:
        .byte   0               ; 1st Fibonacci number

fib2:
        .byte   0               ; 2nd Fibonacci number

temp:
        .byte   0               ; Temporary storage

counter:
        .byte   0               ; Counter

        .end    start
