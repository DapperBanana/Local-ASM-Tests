
    .ORG $0200

check_carmichael:
    LDX #0
    STX divisor     ; Initialize the divisor counter to 0
    LDA input       ; Load the input number into the accumulator
    CMP #$02        ; Check if the input number is less than 2
    BEQ not_carmichael  ; If so, it is not a Carmichael number
    
next_divisor:
    INX             ; Increment the divisor counter
    CPX input       ; Compare the divisor counter with the input number
    BEQ is_carmichael   ; If the divisor counter equals the input number, it is a Carmichael number
    
    LDY #$00        ; Initialize flag for checking Fermat's little theorem
    LDA divisor     ; Load the divisor index into the accumulator
    JSR is_prime    ; Check if the current divisor is a prime number
    BEQ not_carmichael  ; If the current divisor is not prime, it is not a Carmichael number
    
    LDA input       ; Load the input number into the accumulator
    SEC
    SBC divisor     ; Subtract the current divisor from the input number
    STA remainder   ; Store the remainder after division
    
    LDY divisor     ; Load the current divisor into Y register
    LDA remainder   ; Load the remainder back into the accumulator
    JSR mod_pow     ; Calculate remainder^input mod divisor
    
    CPY remainder   ; Check if the remainder is equal to the remainder^input mod divisor
    BEQ not_carmichael  ; If they are equal, it is not a Carmichael number

    JMP next_divisor   ; Otherwise, continue checking the next divisor

is_carmichael:
    LDA #$01
    STA is_carmichael   ; Set flag for Carmichael number
    RTS

not_carmichael:
    LDA #$00
    STA is_carmichael   ; Clear flag for Carmichael number
    RTS

    .ORG $0300

is_prime:
    LDX #$02
check_prime:
    CPX divisor
    BEQ is_prime
    CPY #$00
    BEQ not_prime
    CPY #$01
    BEQ not_prime

    LDA divisor
    JSR div
    BCS not_prime

    INX
    JMP check_prime

div:
    LDA #$00
divloop:
    SEC
    SBC divisor
    BCS divloop
    ADC divisor

    RTS

not_prime:
    LDA #$00
    RTS

mod_pow:
    LDX #$01
    LDA remainder
    STA base
mploop
    JSR mul_mod
    DEX
    BNE mploop

    RTS

mul_mod:
    LDA base
    STA result
    LDY #$01

mulloop:
    CMP #$01
    BEQ done_mul

    SEC
    SBC remainder
    BCS done_mul
    LDY #$00

    LDA result
    ADC base
    STA result

    JMP mulloop

done_mul:
    RTS

    .ORG $0400

input:  .BYTE $0F    ; Change this value to the number you want to test
divisor: .BYTE $00
remainder:  .BYTE $00

is_carmichael:  .BYTE $00
base:   .BYTE $00
result: .BYTE $00
