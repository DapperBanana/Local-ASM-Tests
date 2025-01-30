
    .text
    .org $0200

start:
    LDX #$00      ; Initialize counter
    LDA #$07      ; Number to check (change to desired number)
check_prime:
    INX           ; Increment counter
    LDA #$02      ; Initialize divisor
    JSR is_coprime ; Check if counter is prime
    BMI check_prime

check_carmichael:
    LDA #$02      ; Initialize base
    JSR carmichael_check
    CMP #$01
    BEQ is_carmichael

not_carmichael:
    LDA #$00
    STA $FE        ; Store result
    JMP end

is_carmichael:
    LDX #$01      ; Initialize counter
check_bases:
    INX           ; Increment counter
    CPX #$FE      ; Check all bases up to n-1
    BEQ is_carmichael
    LDA $FE       ; Load number
    JMP check_carmichael

carmichael_check:
    STA $FD       ; Save number
    LDA #$01
    STA $FE       ; Initialize result
    LDX #$00
check_coprime:
    INX
    CPX $FD       ; Check base up to n-1
    BEQ is_prime
    JSR modulo
    BMI coprime_found
    JMP check_coprime

coprime_found:
    LDA #$00
    BMI end

is_prime:
    LDX #$00      ; Initialize counter
    LDY #$00      ; Initialize remainder
check_divisor:
    INX           ; Increment counter
    CPX $FD       ; Check all divisors up to n-1
    BEQ check_prime
    JSR modulo
    CMP #$00
    BNE check_divisor
    LDA #$FF
    BMI end

modulo:
    LDA $FD       ; Load number
    SEC
    SBC $FD       ; Subtract divisor
    RTS

end:
    BRK

    .end
