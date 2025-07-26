
.org $0200

Start:
    LDA #$00         ; Initialize sum to 0
    STA sum
    LDA #$02         ; Start with the first prime number
    STA current_num
    
Loop:
    JSR IsPrime      ; Check if current_num is prime
    BNE NotPrime     ; If not prime, skip adding to sum
    
    CLC
    LDA sum          ; Add prime number to sum
    ADC current_num
    STA sum
    
NotPrime:
    INC current_num   ; Move to the next number
    LDA current_num
    CMP #$FF          ; Check if reached the limit
    BNE Loop
    
Done:
    BRK

IsPrime:
    LDX #$02        ; Start divisor at 2
    
DivLoop:
    CPX current_num   ; Compare divisor with current number
    BEQ IsPrimeEnd    ; If equal, number is prime
    
    CPY #$01          ; Check if divisor is 1
    BEQ IsPrimeEnd    ; If divisor is 1, number is prime
    
    TYA
    CLC
    SBC current_num   ; Divide number by divisor
    BEQ IsNotPrime    ; If division result is 0, not prime
    
    DEX              ; Decrement divisor
    BNE DivLoop      ; Continue division
    
IsPrimeEnd:
    LDA #$00          ; Set return value to 0 (not prime)
    RTS
    
IsNotPrime:
    LDA #$FF          ; Set return value to FF (prime)
    RTS
    
sum: .byte 0
current_num: .byte 0

.end
