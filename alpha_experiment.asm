
        ; Fibonacci sequence using memoization

        ; Define variables for input n and result
n       = $00
result  = $01

        ; Define memory for memoization table
memo    = $40
memo_end = $55

        ; Define constants
FIB_LIMIT = 10

        ; Initialize memoization table with zeros
        LDA #0
init_loop:
        STA memo, x
        INX
        CPX memo_end
        BCC init_loop

        ; Get input n
        LDA #5        ; For example, to calculate the 5th Fibonacci number
        STA n

        ; Check if n is within FIB_LIMIT
        LDA n
        CMP #FIB_LIMIT
        BCC within_limit

        ; If n is greater than FIB_LIMIT, return error code -1
        LDA #-1
        STA result
        JMP end_program

within_limit:
        ; Check if n is less than 0
        LDA n
        BMI negative_input

        ; Check if n is 0 or 1
        LDA n
        BEQ base_case
        CMP #1
        BEQ base_case

        ; Check if result is already in memoization table
        LDX n
        LDA memo, x
        BNE result_found

        ; Calculate Fibonacci sequence recursively
        LDA n
        SEC
        SBC #1
        STA n
        JSR fibonacci
        TAX

        LDA n
        SEC
        SBC #2
        STA n
        JSR fibonacci
        CLC
        ADC result
        STA result

        ; Save result in memoization table
        LDX n
        STA memo, x

result_found:
        ; Return the result
end_program:
        RTS

negative_input:
        ; If n is negative, return error code -1
        LDA #-1
        STA result
        JMP end_program

base_case:
        ; Handle base cases
        LDA n
        STA result
        jmp end_program

fibonacci:
        ; Recursive function to calculate the Fibonacci sequence
        CPX #0
        BEQ fibonacci_base_case
        CPX #1
        BEQ fibonacci_base_case

        SEC
        SBC #1
        STA n
        JSR fibonacci

        LDX n
        SEC
        SBC #2
        STA n
        JSR fibonacci

        LDA n
        SEC
        SBC #1
        TAX
        LDA memo, x
        RTS

fibonacci_base_case:
        ; Handle base cases
        LDA #0
        RTS
