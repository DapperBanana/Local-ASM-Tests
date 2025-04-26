
        ORG $1000
START   LDA #2           ; initialize current number to 2
        STA CURRENT_NUM
        LDA #0           ; initialize sum of primes to 0
        STA SUM_PRIMES
        LDA #0           ; initialize prime flag to 0

LOOP    LDA CURRENT_NUM  ; load current number
        JSR IS_PRIME     ; check if number is prime
        BCC NOT_PRIME     ; branch if not prime
        CLC              ; clear carry for addition
        ADC SUM_PRIMES   ; add current number to sum of primes
        STA SUM_PRIMES    ; store the result
NOT_PRIME
        INC CURRENT_NUM   ; increment current number
        LDA CURRENT_NUM
        CMP LIMIT        ; compare current number to the limit
        BCC LOOP         ; branch if current number is less than limit
        ; output the sum of all prime numbers
        ; code for outputting sum of primes goes here
        RTS

IS_PRIME
        LDX #2           ; start divisor from 2
        LDA CURRENT_NUM  ; load current number
        STX DIVISOR      ; store divisor
DIV_LOOP
        CPX CURRENT_NUM  ; compare divisor to current number
        BEQ IS_PRIME_END ; branch if divisor equals current number
        LDA CURRENT_NUM  
        SEC              ; set carry for division
        SBC DIVISOR      ; subtract divisor from current number
        BCS IS_NOT_PRIME  ; branch if current number < divisor
        LDA #0           ; clear A register
        RTS
IS_NOT_PRIME
        INX              ; increment divisor
        JMP DIV_LOOP
IS_PRIME_END
        LDA #1           ; set prime flag to 1
        RTS

CURRENT_NUM .BYTE 0
SUM_PRIMES .BYTE 0
LIMIT .BYTE 10
DIVISOR .BYTE 0

        JMP START        ; start program execution
