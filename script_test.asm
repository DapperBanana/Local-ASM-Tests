
; Fibonacci sequence calculator using memoization

.segment "CODE"

start:
    LDA #$00        ; Initialize counter to 0
    STA current_count

    LDX #$0A        ; Calculate 10th term of Fibonacci sequence
    JSR fib         ; Call Fibonacci function

    BRK             ; End program

fib:
    ; Check if the current term has already been calculated
    LDA current_count
    CMP X
    BCS calc_fib

    ; If the current term has already been calculated, return its value
    LDA fib_array, X
    RTS

calc_fib:
    ; Base cases for Fibonacci sequence
    CPX #$00
    BEQ base_case_1
    CPX #$01
    BEQ base_case_2

    ; Recursive calculation of Fibonacci sequence
    DEX
    JSR fib         ; Calculate (n-1)th term
    PHA             ; Save result on stack
    DEX
    JSR fib         ; Calculate (n-2)th term

    PLA             ; Retrieve (n-1)th term from stack
    CLC
    ADC fib_array, X    ; Add (n-1)th term
    STA fib_array, current_count  ; Save result in fib_array

base_case_1:
    LDA #$00        ; First base case: fib(0) = 0
    STA fib_array, current_count  ; Save result in fib_array
    RTS

base_case_2:
    LDA #$01        ; Second base case: fib(1) = 1
    STA fib_array, current_count  ; Save result in fib_array
    RTS

.segment "DATA"

fib_array:
    .res $0A    ; Reserve memory for memoization of Fibonacci sequence terms

current_count:
    .res $01    ; Memory location to store current count of Fibonacci terms
