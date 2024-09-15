
        .org $1000    ; start address of the program

start:
        LDX #$00      ; initialize X register to 0
        LDA number    ; load the number to be factorized into the accumulator

find_factors:
        INX           ; increment X
        CPX number    ; compare the number with the current factor
        BEQ end       ; if current factor equals the number, end the program

        LDA number    ; load the number back into the accumulator
        SEC           ; set carry flag
        SBC X         ; subtract the current factor from the number
        BCS find_factors ; loop until the number is less than the current factor

check_prime:
        LDX #$02      ; start checking for prime factors from 2
        LDA X         ; load the current factor into the accumulator
        SEC           ; set carry flag
        SBC number    ; subtract the number by the current factor
        BEQ print_factor ; if the factor divides the number evenly, print it as a prime factor

        INX           ; increment X
        CPX number    ; compare the current factor with the number
        BCS end       ; if the current factor exceeds the number, end the program
        JMP check_prime ; continue checking for prime factors

print_factor:
        STA factor    ; save the prime factor to factor memory location
        LDA factor    ; load the prime factor back into the accumulator
        STA $D020     ; output the prime factor to screen (not a standard output)

end:
        NOP           ; do nothing, end of the program

number: .byte 64      ; change this value to test the program with a different number
factor: .byte $00     ; memory location to store the prime factor

        .end
