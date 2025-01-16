
; Fibonacci program using memoization
.start
    LDX #0          ; initialize counter
    STX index       ; store counter in index
    
    LDX #0          ; initialize first Fibonacci number
    STX fib1        ; store first Fibonacci number in fib1
    
    LDX #1          ; initialize second Fibonacci number
    STX fib2        ; store second Fibonacci number in fib2
    
    LDX #1          ; initialize n
    STX n            ; store n in n
    
.next
    LDA n           ; load n into A
    CMP index       ; compare n and index
    BEQ .done       ; if n = index, we are done
    
    LDA fib1        ; load first Fibonacci number into A
    CLC             ; clear carry flag
    ADC fib2        ; add second Fibonacci number to A
    STA fib1        ; store sum in fib1
    
    LDX fib2        ; move second Fibonacci number into X
    STX fib2        ; store second Fibonacci number in fib2
    LDA fib1        ; load sum into A
    STA fib2        ; store sum in fib2
    
    INX             ; increment counter
    STX index       ; store counter in index
    
    JMP .next       ; repeat until n = index
    
.done
    LDA fib1        ; load nth Fibonacci number into A
    ; print A (nth Fibonacci number)

    BRK             ; end program

n       .BYTE 0
index   .BYTE 0
fib1    .BYTE 0
fib2    .BYTE 0
