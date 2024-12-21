
        .org $0200

START   LDX #2                  ; initialize X register to 2 (first prime number)
        LDY #100                ; set the limit to 100
        
SUMLOOP INX                     ; increment X register to check next number
        CPX #Y                  ; check if X is greater than the limit
        BCS DONE                ; if X is greater than Y, we are done
        
        JSR ISPRIME             ; check if current number is prime
        BEQ PRIME               ; if ISPRIME function returns zero, go to PRIME
        BRA SUMLOOP             ; jump back to SUMLOOP
        
PRIME   CLC                     ; clear carry flag
        ADC X                   ; add prime number to the result
        BRA SUMLOOP             ; jump back to SUMLOOP
        
DONE    BRK                     ; end the program

ISPRIME CPX #2                  ; check if X is 2
        BEQ PRIME               ; if X is 2, it is a prime number
        
        LDA #0                  ; initialize A register to 0 (not a prime number)
        CPY #2                  ; check if Y is 2
        BEQ PRIME               ; if Y is 2, it is a prime number
        
        LDY #2                  ; initialize Y register to 2
        
CHECK   CPY X                   ; check if Y is equal to X
        BEQ PRIME               ; if Y is equal to X, it is a prime number
        
        CPX #0                  ; check if X is 0
        BEQ NOTPRIME            ; if X is 0, it is not a prime number
        
        CPX #1                  ; check if X is 1
        BEQ NOTPRIME            ; if X is 1, it is not a prime number
        
        TYA                     ; move Y to A
        JSR DIV                 ; call DIV function
        
        BEQ NOTPRIME            ; if division result is 0, number is not prime
        
        LDA #0                  ; set A to 0 (not a prime number)
        RTS                     ; return from function
        
NOTPRIME
        LDA #0                  ; set A to 0 (not a prime number)
        RTS                     ; return from function

DIV     SEC                     ; set carry flag
        SBC Y                   ; subtract Y from A
        BCS DIV                 ; if result is positive, continue division
        
        CLC                     ; clear carry flag
        RTS                     ; return from function

        .end
