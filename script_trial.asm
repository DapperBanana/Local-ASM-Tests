
ORG $1000

START LDX #$00         ; initialize counter
    LDY #10            ; starting number
    LDA #01            ; initialize prime counter
LOOP
    JSR ISPRIME        ; check if number is prime
    BCS NOTPRIME       ; branch if not prime
    INC X               ; increment prime counter
NOTPRIME
    INY                 ; increment number
    CPY #$20            ; check end range
    BNE LOOP            ; loop if not end range
    BRK

ISPRIME
    LDX #$02            ; initialize divisor
    LDY #$00            ; initialize remainder counter
DIVLOOP
    CPY X               ; check if divisor reached
    BEQ PRIME          ; if it reached, number is prime
    TYA                 ; transfer number to A
    CPX #$00            ; check if divisor is 0
    BEQ DIVBYZERO      ; check divide by zero error
    LSR                 ; shift right A
    ROR                 ; rotate right A
    SEC                 ; set carry flag
    SBC X               ; subtract divisor from A
    BCS DIVBYZERO      ; check divide by zero error
    BCC CHECKDIVISIBLE  ; check divisible
    INY
    INX                 ; incr divisor
    BCS DIVLOOP        ; loop till divisor reached
CHECKDIVISIBLE
    CPY #$00            ; check remainder
    BEQ PRIME          ; if no remainder, it is prime
    CLR A
    RTS

DIVBYZERO
    RTS

PRIME
    SEC
    SBC #1
    RTS

    .END
