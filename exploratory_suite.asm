
        .org $0200

prime_count = $00
        LDA #$00    ; Initialize prime count to zero
        STA prime_count

        LDX #$02    ; Initialize loop counter to 2

loop:
        CPX #$15    ; Check if loop counter is less than or equal to 20
        BEQ done    ; If so, exit loop

        JSR is_prime    ; Check if current number is prime

        BNE not_prime    ; If not prime, skip increment
        INC prime_count    ; If prime, increment prime count

not_prime:
        INX         ; Increment loop counter
        JMP loop    ; Repeat loop

done:
        BRK

is_prime:
        STA $ff        ; Store current number in temp variable
        LDA prime_count    ; Load prime count
        AND #$ff        ; Clear upper byte
        SEC        
        SBC #$01        ; Subtract 1 from current number
        TAX
        LDA #$02
        JSR divisibility_check    ; Check if current number is divisible by any number
        BCS not_prime    ; If divisible, not a prime number
        LDA #$01        ; If not divisible by any number, set A to 1
        RTS

divisibility_check:
        PHA        ; Save the current index        
loop2:
        SEC
        SBC $ff    ; Subtract current number from the counter
        CPX #$01    ; Check if the current index is 1
        BEQ not_divisible    ; If so, number is prime
        CPX #$02    ; Check if the current index is 2
        BEQ not_divisible    ; If so, number is prime
        CPX #$03    ; Check if the current index is 3
        BEQ not_divisible    ; If so, number is prime
        CPX #$04    ; Check if the current index is 4
        BEQ divisible    ; If so, not a prime number
        CPX #$05    ; Check if the current index is 5
        BEQ not_divisible    ; If so, number is prime
        CPX #$06    ; Check if the current index is 6
        BEQ divisible    ; If so, not a prime number
        CPX #$07    ; Check if the current index is 7
        BEQ not_divisible    ; If so, number is prime
        CPX #$08    ; Check if the current index is 8
        BEQ divisible    ; If so, not a prime number
        CPX #$09    ; Check if the current index is 9
        BEQ divisible    ; If so, not a prime number
        CPX #$0a    ; Check if the current index is 10
        BEQ divisible    ; If so, not a prime number
        CPX #$0b    ; Check if the current index is 11
        BEQ not_divisible    ; If so, number is prime
        CPX #$0c    ; Check if the current index is 12
        BEQ divisible    ; If so, not a prime number
        CPX #$0d    ; Check if the current index is 13
        BEQ not_divisible    ; If so, number is prime
        CPX #$0e    ; Check if the current index is 14
        BEQ divisible    ; If so, not a prime number
        CPX #$0f    ; Check if the current index is 15
        BEQ divisible    ; If so, not a prime number
        CPX #$10    ; Check if the current index is 16
        BEQ divisible    ; If so, not a prime number
        CPX #$11    ; Check if the current index is 17
        BEQ not_divisible    ; If so, number is prime
        CPX #$12    ; Check if the current index is 18
        BEQ divisible    ; If so, not a prime number
        CPX #$13    ; Check if the current index is 19
        BEQ not_divisible    ; If so, number is prime
        CPX #$14    ; Check if the current index is 20
        BEQ not_divisible    ; If so, number is prime
        CPX $ff    ; Compare the current number in the counter with the index
        BEQ not_divisible    ; If the counter still less than the index then the number is prime
        BCS divisible    ; If it's greater, it's divisible, but if it's less than, the check is still going


divisible:
        SEC
        PLP
        RTS

not_divisible:
        SEC
        PLP
        RTS

        .end
