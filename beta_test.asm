
    ; Fibonacci with memoization
    ; Calculate the nth term of the Fibonacci sequence using memoization
    ; Input: n in X register
    ; Output: Fibonacci(n) in A register

    lda #0     ; initialize memoization table
    sta memo1
    sta memo2

loop:
    lda #1     ; check if n <= 1
    cmp x
    beq done

    lda x
    clc
    adc #(-1)
    tax        ; n-1 to X register
    jsr fib     ; Fibonacci(n-1)
    
    sta temp    ; save Fibonacci(n-1) in temp
    lda memo1
    sta fibn1   ; save memo1 in fibn1
    lda memo2
    sta fibn2   ; save memo2 in fibn2
    lda temp
    clc
    lda fibn1
    adc fibn2    ; Fibonacci(n) = Fibonacci(n-1) + Fibonacci(n-2)
    sta memo1    ; update memo1
    sta fibn1    ; update fibn1
    lda fibn2
    sta memo2    ; update memo2
    sta fibn2    ; update fibn2

    jmp loop

done:
    lda memo1   ; result in A register
    rts
    

fib:
    cmp #2
    bcc basecase
    
    lda memo1
    sta fibn1
    lda memo2
    sta fibn2
    
    lda x
    clc
    adc #(-1)
    tax
    jsr fib
    
    lda x
    clc
    adc #(-2)
    tax
    jsr fib
    
    lda fibn1
    clc
    adc fibn2
    sta memo1
    sta fibn1
    lda fibn2
    sta memo2
    sta fibn2
    
    rts
    
basecase:
    lda #1
    rts

memo1 .byte 0
memo2 .byte 0
fibn1 .byte 0
fibn2 .byte 0
temp  .byte 0
