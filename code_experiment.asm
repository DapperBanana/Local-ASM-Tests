
        .org $0200

start   LDX #$02       ; Initialize X register to 2
        LDY num        ; Load the number to check into Y register
        CPY #$02       ; Check if the number is less than 2
        BCC not_prime   ; If the number is less than 2, it is not prime

check   CPX Y          ; Check if X is equal to Y
        BEQ prime      ; If X is equal to Y, the number is prime
        INX            ; Increment X
        CPX Y          ; Compare X with the number
        BNE check      ; If X is not equal to the number, continue checking

not_prime
        LDA #$00       ; Set A register to 0 (not prime)
        BRK

prime   LDA #$01       ; Set A register to 1 (prime)
        BRK

num     .byte $0A      ; The number to check (change this to the desired number)
        
        .end
