
ORG $0200
start:
    LDX #0         ; Initialize index to 0
    LDA numbers, X ; Load the first number from the list
    STA result     ; Initialize result with the first number
    
loop:
    INX            ; Increment index
    CPX #$0B       ; Check if end of list has been reached
    BEQ done       ; If end of list, go to done
    
    LDA numbers, X ; Load next number from list
    JSR calc_lcm   ; Calculate LCM of current result and new number
    BRA loop       ; Repeat the loop
    
done:
    BRK

calc_lcm: 
    PHA            ; Save the accumulator on stack
    PHX            ; Save the index on stack
    
    ; Calculate the LCM of two numbers
    LDX result     ; Load result value
    CLC
    ADC numbers, X ; Add the next number
    STA acc        ; Store the result in acc
    LDA result     ; Load result value
    JSR gcd        ; Call the subroutine to calculate GCD
    LDX acc        ; Load GCD value in X 
    LDA acc        ; Load GCD value in A
    SEC
    SBC acc        ; Sub the GCD value from Accumulator 
    TAY            ; Load result to Y Register
    LDA numbers, X ; Load number from list in A
    JSR mul        ; Multiply the number with calculated GCD
    LDX acc        ; Load the result in X
    STX result     ; Store the result back in result
    
    PLX            ; Restore the index
    PLA            ; Restore the accumulator
    RTS

gcd:
    PHA  ; Save the accumulator on stack
    PHX  ; Save the index on stack

gcd_loop:
    CPX #$0B ; Check if index has reached end of list
    BEQ gcd_done ; If yes, return
    
    LDA result
    SEC
    SBC numbers, X ; Subtract each number in the list from result
    STA result
    BEQ gcd_done ; If result becomes 0, return
    
    INX
    BRA gcd_loop

gcd_done:
    PLA  ; Restore the index
    PLX  ; Restore the accumulator
    RTS

mul:
    PHA  ; Save the accumulator on stack
    PHX  ; Save the index on stack

mul_loop:
    CPX acc  ; Check if index has reached number of times the GCD
    BEQ mul_done ; If yes, return
    
    CLC
    ADC acc
    DEX  ; decrement the counter
    BRA mul_loop

mul_done:
    PLA  ; Restore the index
    PLX  ; Restore the accumulator
    RTS

numbers:
    .BYTE $0A, $0B, $0F, $12, $15 ; List of numbers
result:
    .BYTE $00 ; Store LCM result
acc:
    .BYTE $00 ; Store temporary result

    JMP start
