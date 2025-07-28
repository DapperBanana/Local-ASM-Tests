
.org $0200

start:
    LDX #2         ; Set X to the first prime number
    LDY #0         ; Initialize sum to 0
    STY $FF        ; Store the sum at memory location $FF

loop:
    JSR is_prime   ; Check if X is a prime number
    BCS not_prime  ; Branch if X is not a prime number

    CLC
    LDA $FF        ; Load the current sum
    ADC X          ; Add the current prime number (X) to the sum
    STA $FF        ; Store the new sum

not_prime:
    INX            ; Increment X
    CPX #10        ; Check if we have reached the limit
    BCC loop       ; Loop back if X < 10

    BRK            ; Exit program

is_prime:
    TYA            ; Save A on stack
    TXA            ; Save X on stack

    LDA #2         ; Load divisor
div_loop:
    CMP X          ; Compare dividend X with divisor
    BCC prime      ; Branch if dividend is smaller
    CPY X          ; Compare divisor with dividend
    BEQ prime      ; Branch if divisor is equal to dividend

    INY            ; Increment Y
    CLC
    ADC X          ; Add the divisor to the dividend
    BCC div_loop   ; Continue division

    JMP not_prime  ; Branch if dividend is not prime

prime:
    PLA            ; Restore X from stack
    TAY            ; Restore A from stack
    RTS            ; Return

.org $FF00
    .byte 0        ; Initialize sum to 0

.include "6502.mac"
