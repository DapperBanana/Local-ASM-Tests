
    LDA #0            ; Initialize sum to 0
    STA $00
    
    LDX #2            ; Start from the first prime number
check_prime:
    LDY #2            ; Start checking from 2
    CPY X             ; Compare X and Y
    BEQ is_prime      ; If X equals Y, then X is prime
    
check_divisible:
    INY               ; Increment Y
    CPY X             ; Compare X and Y
    BEQ is_prime      ; If X equals Y, then X is prime
    CPY #0            ; Compare Y and 0
    BEQ check_prime   ; If Y equals 0, then X is prime
    CPY X             ; Compare X and Y
    BNE check_divisible ; If X is not divisible by Y, check next divisor
    
is_prime:
    CLC               ; Clear carry for addition
    ADC X             ; Add X to sum
    STA $00           ; Update sum
    
    INX               ; Increment X
    CPX R0            ; Compare X and the specified limit
    BCC check_prime   ; If X is less than the limit, check next number
    
    LDA $00           ; Load the final sum
    ; The result is now in the A register
    
    BRK               ; Exit program
