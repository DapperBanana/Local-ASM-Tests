
        .org $0200

START   LDX #NUMBER      ; Load number to check for prime
        INX              ; Increase number by 1
LOOP    
        JSR ISPRIME      ; Check if current number is prime
        BEQ FOUND        ; If prime, exit loop
        INX              ; Otherwise, increase number by 1
        JMP LOOP         ; Continue loop

FOUND   STX PRIME        ; Store prime number
        LDA PRIME
        JSR PRINT         ; Print prime number
        BRK

ISPRIME LDA #2           ; Start divisor at 2
DIVLOOP CMP #0           ; Check if number is divisible
        BEQ PRIME        ; If divisible, not prime
        LSR              ; Shift number right
        BCC DIVLOOP      ; Repeat until division is even
        RTS

PRIME   .byte $00        ; Placeholder for prime number
NUMBER  .byte $0A        ; Given number

PRINT   LDX #$04         ; Set loop counter
        LDY PRIME
LOOP2   LDA #3           ; Character to print
        JSR $FFD2        ; Print character
        INY              ; Move to next character
        DEX              ; Decrement loop counter
        BNE LOOP2        ; Continue until all characters printed
        RTS

        .end
